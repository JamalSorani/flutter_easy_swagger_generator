import {
  IProperty,
  IResponse,
  IParameter,
  IOpenApiJSON,
  IRefProperty,
  IRequestBody,
  IPropertyProperties,
} from "../types/fetch-swagger-data.types.js";
import {
  applyOr,
  nullable,
  applyAnd,
  getFileDtos,
  isRefProperty,
  appendNewLine,
  isArrayProperty,
  isObjectProperty,
  isNumberProperty,
  convertToKebabCase,
  isPrimitiveProperty,
  getApiNameFromRoute,
  dtoNameToInterfaceName,
  getControllerNameFromRoute,
  allowGenerateController,
  handleMultiItemsArrow,
} from "../helpers/fetch-swagger-data.helpers.js";
import * as fs from "fs";
import * as path from "path";

const [controllerNameToGenerate] = process.argv.slice(2);

const openApiJsonToInterface = (
  openApiJson: IOpenApiJSON,
  outputLocation: string,
  getControllerFuncFromSettings: string | undefined,
  includedControllers: string[],
  excludedControllers: string[],
  interfaceNameConverter: string,
  apiNameConverter: string,
  nullSafety: boolean
) => {
  const { paths, components } = openApiJson;

  const dtosInCommon: { [dtoName: string]: IRefProperty | string } = {}; // dtoName: interfaces
  const interfaces: { [controllerName: string]: string[] } = {}; // {controllerName: controllerInterfaces[]}
  const schemasInterfaces: {
    [dtoName: string]: string;
  } = {};

  let controllerName = "";
  let isPostProcessing = false;

  // ----------------------------------------------------------------------

  // #region preProcessing

  const preProcessing = () => {
    const recGetRef = (property: IProperty) => {
      if (isRefProperty(property)) {
        const dtoName: string = property.$ref.replace(
          "#/components/schemas/",
          ""
        );

        if (
          dtosInCommon[dtoNameToInterfaceName(dtoName, interfaceNameConverter)]
        ) {
          return;
        }

        dtosInCommon[
          dtoNameToInterfaceName(
            property.$ref.replace("#/components/schemas/", ""),
            interfaceNameConverter
          )
        ] = property;

        const data = components.schemas[dtoName];
        recGetRef(data);
        return;
      }
      if (isObjectProperty(property)) {
        Object.values({
          ...(property.properties || {}),
        }).forEach(recGetRef);
        if (
          property.additionalProperties &&
          property.additionalProperties !== true
        ) {
          if (isRefProperty(property.additionalProperties)) {
            recGetRef(property.additionalProperties);
          }
        }
        return;
      }
      if (isArrayProperty(property) && property.items) {
        recGetRef(property.items);
      }
      property.allOf?.filter(isRefProperty).map(recGetRef);
      property.anyOf?.filter(isRefProperty).map(recGetRef);
      property.oneOf?.filter(isRefProperty).map(recGetRef);

      property.allOf?.filter(isObjectProperty).map(recGetRef);
      property.anyOf?.filter(isObjectProperty).map(recGetRef);
      property.oneOf?.filter(isObjectProperty).map(recGetRef);

      property.allOf?.filter(isArrayProperty).map(recGetRef);
      property.anyOf?.filter(isArrayProperty).map(recGetRef);
      property.oneOf?.filter(isArrayProperty).map(recGetRef);
    };

    Object.entries(paths).forEach(([route, obj]) => {
      const [, data] = Object.entries(obj)[0];

      if (
        allowGenerateController({
          controllerName: getControllerNameFromRoute(
            route,
            getControllerFuncFromSettings,
            true
          ),
          controllerNameToGenerate,
          excludedControllers,
          includedControllers,
        })
      ) {
        // query params properties
        data.parameters
          ?.filter((p) => p.in === "query")
          .forEach((parameter) => {
            if (parameter.schema) {
              recGetRef(parameter.schema);
            }
          });

        // request properties
        if (data.requestBody?.content) {
          const { schema } = Object.values(data.requestBody.content)[0];
          if (schema) {
            recGetRef(schema);
          }
        }

        // response properties
        if (data.responses?.["200"]?.content) {
          const { schema } = Object.values(data.responses?.["200"]?.content)[0];

          if (schema) {
            recGetRef(schema);
          }
        }
      }
    });
  };

  preProcessing();

  // #endregion

  // ----------------------------------------------------------------------

  // #region processing

  const getRef = (
    property: IRefProperty & { enum?: (number | string)[] },
    isPropertyOfArray: boolean,
    isFirstLevel: boolean
  ): string => {
    const dtoName = property.$ref.replace("#/components/schemas/", "");
    const data = components.schemas[dtoName];

    if (isPostProcessing) {
      if (
        schemasInterfaces[
          dtoNameToInterfaceName(dtoName, interfaceNameConverter)
        ]
      ) {
        if (isFirstLevel) {
          return schemasInterfaces[
            dtoNameToInterfaceName(dtoName, interfaceNameConverter)
          ];
        }
        return dtoNameToInterfaceName(dtoName, interfaceNameConverter);
      }
    } else if (
      dtosInCommon[dtoNameToInterfaceName(dtoName, interfaceNameConverter)] ||
      schemasInterfaces[dtoNameToInterfaceName(dtoName, interfaceNameConverter)]
    ) {
      return dtoNameToInterfaceName(dtoName, interfaceNameConverter);
    }

    schemasInterfaces[dtoNameToInterfaceName(dtoName, interfaceNameConverter)] =
      dtoNameToInterfaceName(dtoName, interfaceNameConverter);
    schemasInterfaces[dtoNameToInterfaceName(dtoName, interfaceNameConverter)] =
      getProperty(data, isPropertyOfArray, false);
    if (isPostProcessing) {
      dtosInCommon[controllerName] =
        schemasInterfaces[
          dtoNameToInterfaceName(dtoName, interfaceNameConverter)
        ];

      if (isFirstLevel) {
        return schemasInterfaces[
          dtoNameToInterfaceName(dtoName, interfaceNameConverter)
        ];
      }

      return dtoNameToInterfaceName(dtoName, interfaceNameConverter);
    }

    if (property.enum || data.enum) {
      return `${getEnum(property)}`;
    }

    interfaces[controllerName].push(
      `type ${dtoNameToInterfaceName(dtoName, interfaceNameConverter)} = ${
        schemasInterfaces[
          dtoNameToInterfaceName(dtoName, interfaceNameConverter)
        ]
      }`
    );

    return dtoNameToInterfaceName(dtoName, interfaceNameConverter);
  };

  // ----------------------------------------------------------------------

  const getEnum = (property: IProperty): string => {
    if (!property.type && (property as any).$ref) {
      const enumName = (property as any).$ref.replace(
        "#/components/schemas/",
        ""
      );
      const data = components.schemas[enumName];

      return `${applyOr(data.enum || [])}`;
    }

    return "''";
  };

  // ----------------------------------------------------------------------

  const getObject = (
    properties: IPropertyProperties | undefined,
    isPropertyOfArray: boolean,
    additionalProperties: IProperty | undefined
  ) => {
    let content = `\t{\n`;

    if (properties) {
      Object.entries(properties).forEach(([propertyName, p]) => {
        content += `\t"${propertyName}": ${getProperty(p, false, false)}`;
      });
    }

    if (additionalProperties) {
      content += `\t[key: string]: ${getProperty(
        additionalProperties,
        isPropertyOfArray,
        false
      )}`;
    }

    content += `}`;

    return content;
  };

  // ----------------------------------------------------------------------

  // this function includes "nullable(property)\n;"
  const getProperty = (
    property: IProperty,
    isPropertyOfArray: boolean,
    isFirstLevel: boolean
  ): string => {
    property.type = Array.isArray(property.type)
      ? property.type?.[0]
      : property.type;

    if (property.enum) {
      return `${applyOr(
        property.enum.map((el) => (typeof el === "string" ? `"${el}"` : el))
      )}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}`;
    }

    if (isPrimitiveProperty(property)) {
      if (isNumberProperty(property)) {
        return `number${nullable(property, nullSafety)}${appendNewLine(
          isPropertyOfArray
        )}`;
      }
      return `${property.type}${nullable(property, nullSafety)}${appendNewLine(
        isPropertyOfArray
      )}`;
    }

    if (isArrayProperty(property)) {
      if (property.items) {
        return `${handleMultiItemsArrow(
          getProperty(property.items, true, false)
        )}[]${nullable(property, nullSafety)}${appendNewLine(
          isPropertyOfArray
        )}`;
      }
      return `[]${nullable(property, nullSafety)}${appendNewLine(
        isPropertyOfArray
      )}`;
    }

    if (isObjectProperty(property)) {
      return `${getObject(
        property.properties,
        isPropertyOfArray,
        property.additionalProperties === true
          ? undefined
          : property.additionalProperties
      )}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}`;
    }

    if (
      !property.type &&
      (property as any).$ref === "#/components/schemas/System.TimeSpan"
    ) {
      return `string${nullable(property, nullSafety)}${appendNewLine(
        isPropertyOfArray
      )}`;
    }

    if (isRefProperty(property)) {
      return `${getRef(property, isPropertyOfArray, isFirstLevel)}${nullable(
        property,
        nullSafety
      )}${appendNewLine(isPropertyOfArray)}`;
    }

    if (property.oneOf) {
      return `${applyOr(
        property.oneOf.map((p) => getProperty(p, true, false))
      )}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}`;
    }

    if (property.anyOf) {
      return `${handleMultiItemsArrow(
        applyOr(property.anyOf.map((p) => getProperty(p, true, false)))
      )}[]${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}`;
    }

    if (property.allOf) {
      return `${applyAnd(
        property.allOf.map((p) => getProperty(p, true, false))
      )}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}`;
    }

    if (property.AnyValue) {
      return `any${nullable(property, nullSafety)}${appendNewLine(
        isPropertyOfArray
      )}`;
    }

    return `''${nullable(property, nullSafety)}${appendNewLine(
      isPropertyOfArray
    )}`;
  };

  // ----------------------------------------------------------------------

  const getQueryParams = (parameters: IParameter[]) => {
    let content = `\tqueryParams: {\n`;

    parameters.forEach((parameter) => {
      if (parameter.schema) {
        content += `\t\t"${parameter.name}"${
          parameter.required ? "" : "?"
        }: ${getProperty(parameter.schema, false, true)}`;
      }
    });

    content += `\t}\n`;

    return content;
  };

  // ----------------------------------------------------------------------

  const getPathParams = (parameters: IParameter[]) => {
    let content = `\tpathParams: [`;

    parameters.forEach((parameter, i) => {
      if (parameter.schema) {
        content += `${parameter.name}${
          parameter.required ? "" : "?"
        }: ${getProperty(parameter.schema, true, true)}${
          i !== parameters.length - 1 ? "," : ""
        }`;
      }
    });

    content += `]\n;`;

    return content;
  };

  // ----------------------------------------------------------------------

  const getBodyPayload = (requestBody: IRequestBody) => {
    if (!requestBody?.content) {
      return "''";
    }

    let content = `\tbodyPayload: `;

    const [, data] = Object.entries(requestBody.content)[0];

    if (!data.schema) {
      return "''";
    }

    content += getProperty(data.schema, false, true);

    return content;
  };

  // ----------------------------------------------------------------------

  const getResponsePayload = (response: IResponse) => {
    if (!response?.["200"]?.content) {
      return "''";
    }

    const [, data] = Object.entries(response?.["200"]?.content)[0];

    if (!data?.schema) {
      return "''";
    }

    return getProperty(data.schema, false, true);
  };

  // ----------------------------------------------------------------------

  let routeFlag: { [route: string]: boolean } = {};

  Object.entries(paths).forEach(([route, obj]) => {
    let apiName = getApiNameFromRoute(
      route,
      true,
      getControllerFuncFromSettings,
      apiNameConverter
    );

    let i = 1;
    while (routeFlag[apiName]) {
      apiName = `${apiName}${i}`;
      i++;
    }
    routeFlag[apiName] = true;

    controllerName = getControllerNameFromRoute(
      route,
      getControllerFuncFromSettings,
      true
    );

    if (
      allowGenerateController({
        controllerName,
        controllerNameToGenerate,
        excludedControllers,
        includedControllers,
      })
    ) {
      if (!interfaces[controllerName]) {
        interfaces[controllerName] = [];
      }

      const [, data] = Object.entries(obj)[0];

      const queryParameters = data.parameters?.filter((p) => p.in === "query");
      const pathParameters = data.parameters?.filter((p) => p.in === "path");

      if (
        pathParameters?.length ||
        queryParameters?.length ||
        data.requestBody?.content
      ) {
        const requestInterfaceName = `I${apiName}Request`;

        let content = `export type ${requestInterfaceName} = {\n`;

        if (queryParameters?.length) {
          content += getQueryParams(queryParameters);
        }

        if (pathParameters?.length) {
          content += getPathParams(pathParameters);
        }

        if (data.requestBody?.content) {
          content += getBodyPayload(data.requestBody);
        }

        content += "}\n";

        interfaces[controllerName].push(content);
      }

      if (data.responses?.["200"]?.content) {
        const responseInterfaceName = `I${apiName}Response`;

        let content = `export type ${responseInterfaceName} = `;

        const responsePayload = getResponsePayload(data.responses);
        content += responsePayload;

        interfaces[controllerName].push(content);
      }
    }
  });

  // #endregion

  // ----------------------------------------------------------------------

  // #region postProcessing

  isPostProcessing = true;

  const printCommonInterfacesFile = () => {
    if (!Object.entries(dtosInCommon).length) return;

    const fPath = path.join(outputLocation, "common.interface.ts");

    let result = "";

    Object.entries(dtosInCommon).forEach(([dto, prop]) => {
      result += `export type ${dto} = ${
        typeof prop === "string" ? prop : getProperty(prop, false, true)
      }\n`;
    });

    fs.writeFileSync(fPath, result.replaceAll(`;\n;`, ";\n").trim());
  };

  const importDtosInCommonAndPrint = () => {
    if (!controllerNameToGenerate) {
      printCommonInterfacesFile();
    }

    Object.entries(interfaces).forEach(([cName, controllerInterfaces]) => {
      if (
        allowGenerateController({
          controllerName: cName,
          controllerNameToGenerate,
          excludedControllers,
          includedControllers,
        })
      ) {
        const filePath = path.join(
          outputLocation,
          convertToKebabCase(cName),
          `${convertToKebabCase(cName)}.interface.ts`
        );
        let result = controllerInterfaces.join("\n\n");

        const dtosToImports: string[] = [];

        Object.keys(dtosInCommon).forEach((dto) => {
          if (
            getFileDtos(result).some((fileDto) =>
              fileDto.split(" ").some((el) => {
                return el[0] === "(" && el.at(-1) === ")"
                  ? el.slice(1, -1) === dto
                  : el === dto;
              })
            )
          ) {
            dtosToImports.push(dto);
          }
        });

        dtosToImports.sort((a, b) => a.length - b.length);

        if (!controllerNameToGenerate) {
          if (dtosToImports.length) {
            result = `import {\n\t${dtosToImports.join(
              ",\n\t"
            )}\n} from "../common.interface";\n\n// ----------------------------------------------------------------------\n\n${result}`;
          }
        } else {
          Object.entries(dtosInCommon).forEach(([dto, prop]) => {
            result += `export type ${dto} = ${
              typeof prop === "string" ? prop : getProperty(prop, false, true)
            }\n`;
          });
        }

        result = result.replaceAll(`;\n;`, ";\n");

        if (result.length) fs.writeFileSync(filePath, result);
      }
    });
  };

  // REPLACING

  // #endregion

  // ----------------------------------------------------------------------

  // #region execute

  // replacingInterfacesNamesToUserInterfacesNames()

  importDtosInCommonAndPrint();

  // #endregion

  // ----------------------------------------------------------------------
};

export default openApiJsonToInterface;
