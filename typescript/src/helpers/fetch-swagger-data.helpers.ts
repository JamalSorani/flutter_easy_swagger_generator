import {
  IProperty,
  TDataType,
  TMethodType,
  IRefProperty,
  IArrayProperty,
  IObjectProperty,
  IParameter,
  IOpenApiJSON,
  TControllerInfo,
  TMediaType,
  TRouteInfo,
} from "../types/fetch-swagger-data.types.js";
import * as fs from "fs";
import * as path from "path";

// ----------------------------------------------------------------------

export const getFileDtos = (fileResult: string) =>
  fileResult
    .split("\n")
    .map((el) =>
      el.startsWith("\t[key: string]:")
        ? el.split("\t[key: string]:")[1]
        : el.split(/[:=]/)[1]
    )
    .filter(Boolean)
    .map((el) =>
      el.split(";")[0].replaceAll("[]", "").replaceAll(" | null", "").trim()
    )
    .filter(
      (el) => el !== "{" && !["boolean", "number", "string"].includes(el)
    );

export const toCamelCase = (str: string) =>
  str
    .replace(/([A-Z])/g, "_$1")
    .toLowerCase()
    .replace(/^_/, "")
    .replace(/_./g, (match) => match[1].toUpperCase());

export const convertToKebabCase = (input: string) => {
  const kebabCase = input
    .replace(/([a-z])([A-Z])/g, "$1-$2")
    .replace(/([A-Z]+)/g, "-$1")
    .toLowerCase();

  return (
    kebabCase.startsWith("-") ? kebabCase.slice(1) : kebabCase
  ).replaceAll("--", "-");
};

export const appendNewLine = (isPropertyOfArray: boolean) =>
  isPropertyOfArray ? "" : ";\n";

export const nullable = (property: IProperty, nullSafety: boolean) =>
  `${
    property.nullable &&
    (nullSafety === true || nullSafety?.toString() === "true")
      ? " | null"
      : ""
  }`;

export const applyOr = (array: (string | number)[]) => array.join(" | ");

export const applyAnd = (array: (string | number)[]) => array.join(" & ");

export const dtoNameToInterfaceName = (
  dtoName: string,
  interfaceNameConverter: string
) => {
  let result = dtoName
    .replace(/[.`[\](),=+\s]/g, "")
    .replaceAll("{", "")
    .replaceAll("}", "")
    .replaceAll("'", "")
    .replaceAll('"', "");
  if (interfaceNameConverter) {
    result = eval(interfaceNameConverter)(result);
  }
  return result;
};

export const handleParameterInPath = (
  route: string,
  parametersInPath: IParameter[]
) => {
  if (route.includes("{")) {
    return `(${route
      .match(/{[^}]*}/g)
      ?.map(
        (el) =>
          `${el}: ${
            parametersInPath.find((p) => p.name === el.slice(1, -1))?.schema
              ?.type || "number | string"
          }`
      )
      ?.join(`, `)
      .replaceAll("{", "")
      .replaceAll("}", "")}) => ${`\`${route.replaceAll("{", "${")}\``}`;
  }

  return `'${route}'`;
};

export const handleParameterInPathForApi = (
  apiName: string,
  hasPathParams: boolean
) => {
  if (hasPathParams) {
    return `${apiName}(...payload.pathParams)`;
  }
  return apiName;
};

export const handleParameterInQueryAndBodyForApi = (
  hasQueryParams: boolean,
  hasBodyPayload: boolean,
  isArrayBodyPayload: boolean,
  methodType: TMethodType,
  enableConfig: boolean
) => {
  const queryParams = enableConfig
    ? `\n      params: {
        ...payload.queryParams,
        ...axiosConfig?.params,
      },\n`
    : `\n      params: payload.queryParams\n`;
  const axiosConfig = enableConfig ? `\n      ...axiosConfig,` : ``;
  const bodyPayload = enableConfig
    ? `${!hasQueryParams ? `\n` : ""}      data: ${
        isArrayBodyPayload
          ? `[...payload.bodyPayload, ...(axiosConfig?.data||[])],`
          : `{
        ...payload.bodyPayload,
        ...axiosConfig?.data,
      }`
      }\n`
    : `\n      data: payload.bodyPayload,\n`;

  if (methodType === "post" || methodType === "put" || methodType === "patch") {
    if (hasQueryParams && hasBodyPayload) {
      return `payload.bodyPayload,\n\t\t{${axiosConfig}${queryParams}}`;
    }
    if (hasQueryParams) {
      return `null,\n\t\t{${axiosConfig}${queryParams}}`;
    }
    if (hasBodyPayload) {
      return `payload.bodyPayload,${enableConfig ? `\n    axiosConfig,` : ``}`;
    }
  }
  if (hasQueryParams && hasBodyPayload) {
    return `{${axiosConfig}${queryParams}${bodyPayload}\t\t}`;
  }
  if (hasQueryParams) {
    return `${!enableConfig ? " " : ""}{${axiosConfig}${queryParams}\t\t}`;
  }
  if (hasBodyPayload) {
    return `{${axiosConfig}${bodyPayload}\t\t}`;
  }
  return enableConfig ? `axiosConfig,` : ``;
};

export const handleResponseInApi = (hasResponse: boolean, apiName: string) => {
  if (hasResponse) {
    return `<I${apiName}Response>`;
  }
  return "";
};

export const getApiNameFromRoute = (
  route: string,
  withController: boolean,
  getControllerNameFromRouteFn: string | undefined,
  apiNameConverter: string
) => {
  const controller = getControllerNameFromRoute(
    route,
    getControllerNameFromRouteFn,
    false
  );
  const indexOfController = route.indexOf(controller);

  let result = withController
    ? route.slice(indexOfController)
    : route.slice(indexOfController + controller.length + 1);

  if (!withController && !result) {
    result = route.slice(indexOfController);
  }

  result = result
    .replaceAll("{", "")
    .replaceAll("}", "")
    .replace(/\//g, " ")
    .split(" ")
    .map((w: string) => w.charAt(0).toUpperCase() + w.slice(1))
    .join("");

  result = fixCpapCaseMethod(result);

  if (result === "Delete") {
    result = "Remove";
  }

  if (apiNameConverter) {
    result = eval(apiNameConverter)(result);
  }

  return result;
};

const fixCpapCaseMethod = (s: string) =>
  s
    .replace(/-/g, " ")
    .split(" ")
    .map((w: string) => w.charAt(0).toUpperCase() + w.slice(1))
    .join("");

export const getControllerNameFromRoute = (
  route: string,
  funcFromSettings: string | undefined,
  fixCpapCase: boolean
) => {
  if (funcFromSettings) {
    if (eval(funcFromSettings)(route) === null) return null;

    return fixCpapCase
      ? fixCpapCaseMethod(eval(funcFromSettings)(route))
      : eval(funcFromSettings)(route);
  }

  return route.split("/")[2];
};

// ----------------------------------------------------------------------

export const isPrimitiveProperty = (property: IProperty): boolean => {
  if (!property.type) {
    return false;
  }

  let type = property.type;

  if (Array.isArray(type)) type = type[0];

  const primitiveTypes: TDataType[] = [
    "number",
    "integer",
    "string",
    "boolean",
  ];
  return primitiveTypes.includes(type);
};

export const isNumberProperty = (property: IProperty): boolean => {
  if (!property.type) {
    return false;
  }

  const primitiveTypes: TDataType[] = ["number", "integer"];
  return primitiveTypes.includes(property.type);
};

export const isRefProperty = (property: IProperty): property is IRefProperty =>
  !property.type && !!(property as any).$ref;

export const isObjectProperty = (
  property: IProperty
): property is IObjectProperty => property.type === "object";

export const isArrayProperty = (
  property: IProperty
): property is IArrayProperty => property.type === "array";

export const readConfig = (configPath: string) => {
  try {
    const configFile = fs.readFileSync(configPath, "utf8");
    return JSON.parse(configFile);
  } catch (error: any) {
    console.error(`Error reading config file: ${error.message}`);
    process.exit(1);
  }
};

// Modify the configuration (add or update properties)
// configFile.newProperty = "New Value"; // Add a new property
// configFile.existingProperty = "Updated Value"; // Update an existing property

// Write the updated configuration back to the file
// writeConfig(configFile);

export const writeConfig = (configFile: string) => {
  try {
    fs.writeFileSync(configFile, JSON.stringify(configFile, null, 2), "utf8");
  } catch (error: any) {
    console.error(`Error writing to config file: ${error.message}`);
    process.exit(1);
  }
};

export const allowGenerateController = ({
  controllerName,
  controllerNameToGenerate,
  includedControllers,
  excludedControllers,
}: {
  controllerName: string;
  controllerNameToGenerate: string;
  includedControllers: string[] | undefined;
  excludedControllers: string[] | undefined;
}) => {
  if (controllerNameToGenerate)
    return controllerName === controllerNameToGenerate;

  let result = true;

  if (includedControllers?.length) {
    result &&= includedControllers.includes(controllerName);
  }

  if (excludedControllers?.length) {
    result &&= !excludedControllers.includes(controllerName);
  }

  result &&= controllerName !== null;

  return result;
};

export async function fetchSwaggerJson({
  inputSource,
}: {
  inputSource: string;
}): Promise<IOpenApiJSON> {
  if ((inputSource as string).endsWith(".js")) {
    if (
      inputSource.startsWith("http://") ||
      inputSource.startsWith("https://")
    ) {
      // Fetch data from the URL
      try {
        const response = await fetch(inputSource);
        if (!(response as any).ok) {
          throw new Error(`HTTP error! status: ${(response as any).status}`);
        }
        const file = await (response as any).text();
        const paths = file
          .slice(
            file.indexOf('    "paths": {'),
            file.indexOf(`,
    "info": {`)
          )
          .trim();

        const components = file
          .slice(
            file.indexOf('    "components": {'),
            file.indexOf(`,
  "customOptions": {`)
          )
          .trim()
          .slice(0, -1)
          .trim();

        return JSON.parse(`{
          ${paths},
          ${components}
        }`) as IOpenApiJSON;
      } catch (error) {
        console.error("Error fetching data from URL:", error);
        throw error; // Rethrow or handle as needed
      }
    } else {
      // Read data from the JSON file
      const resolvedInputSource = path.resolve(inputSource);
      return new Promise((resolve, reject) => {
        fs.readFile(resolvedInputSource, "utf8", (err: any, data: any) => {
          if (err) {
            console.error(
              `Error reading file from ${resolvedInputSource}:`,
              err
            );
            return reject(err);
          }
          try {
            const file = data;

            const paths = JSON.parse(
              file
                .slice(file.indexOf("paths"), file.indexOf("info"))
                .trim()
                .slice(-1)
            );
            const components = JSON.parse(
              file
                .slice(
                  file.indexOf("components"),
                  file.indexOf("customOptions")
                )
                .trim()
                .slice(-2)
            );

            return {
              paths,
              components,
            } as IOpenApiJSON;
          } catch (parseError) {
            console.error("Error parsing JSON data:", parseError);
            return reject(parseError);
          }
        });
      });
    }
  } else if (
    inputSource.startsWith("http://") ||
    inputSource.startsWith("https://")
  ) {
    // Fetch data from the URL
    try {
      const response = await fetch(inputSource);
      if (!(response as any).ok) {
        throw new Error(`HTTP error! status: ${(response as any).status}`);
      }
      const jsonData = await (response as any).json();
      return jsonData as IOpenApiJSON;
    } catch (error) {
      console.error("Error fetching data from URL:", error);
      throw error; // Rethrow or handle as needed
    }
  } else {
    // Read data from the JSON file
    const resolvedInputSource = path.resolve(inputSource);
    return new Promise((resolve, reject) => {
      fs.readFile(resolvedInputSource, "utf8", (err: any, data: any) => {
        if (err) {
          console.error(`Error reading file from ${resolvedInputSource}:`, err);
          return reject(err);
        }
        try {
          const jsonData = JSON.parse(data) as IOpenApiJSON;
          return resolve(jsonData);
        } catch (parseError) {
          console.error("Error parsing JSON data:", parseError);
          return reject(parseError);
        }
      });
    });
  }
}

export const prepareControllersRoutes = ({
  paths,
  getControllerFuncFromSettings,
  controllerNameToGenerate,
  excludedControllers,
  includedControllers,
  reactQueryPageParam,
}: {
  paths: IOpenApiJSON["paths"];
  getControllerFuncFromSettings: string;
  controllerNameToGenerate: string;
  excludedControllers: string[];
  includedControllers: string[];
  reactQueryPageParam: string[];
}) => {
  const controllersRoutes: TControllerInfo = {};

  Object.entries(paths).forEach(([route, methods]) => {
    const controllerName = getControllerNameFromRoute(
      route,
      getControllerFuncFromSettings,
      true
    ); // Use the first segment as controller name

    if (
      allowGenerateController({
        controllerName,
        controllerNameToGenerate,
        excludedControllers,
        includedControllers,
      })
    ) {
      const [methodType, data] = Object.entries(methods)[0];

      let hasBodyPayload = false;
      let isArrayBodyPayload = false;
      let hasResponse = false;
      let hasPageParamInQuery: string[] =
        data.parameters
          ?.filter(
            (p) => p.in === "query" && reactQueryPageParam.includes(p.name)
          )
          .map((el) => el.name) || [];
      let hasPageParamInBody: string[] = [];

      if (data.requestBody?.content) {
        hasBodyPayload = !!Object.values(data.requestBody?.content)[0]?.schema;
        const requestProperty = Object.values(data.requestBody?.content)[0]
          ?.schema;
        isArrayBodyPayload = isArrayProperty(
          Object.values(data.requestBody?.content)[0]?.schema
        );
        hasPageParamInBody =
          isObjectProperty(requestProperty) && !!requestProperty.properties
            ? Object.keys(requestProperty.properties).filter((k) =>
                reactQueryPageParam.includes(k)
              )
            : [];
      }

      let mediaType: TMediaType = "application/json";

      if (data.responses?.[200]?.content) {
        hasResponse = !!Object.values(data.responses?.[200]?.content)[0]
          ?.schema;
        mediaType = Object.keys(
          data.responses?.[200]?.content
        )[0] as TMediaType;
      }

      const routeInfo: TRouteInfo[string] = {
        hasBodyPayload,
        isArrayBodyPayload,
        hasResponse,
        hasPathParams: !!data.parameters?.some((p) => p.in === "path"),
        hasQueryParams: !!data.parameters?.some((p) => p.in === "query"),
        hasPageParamInBody,
        hasPageParamInQuery,
        methodType: methodType as TMethodType,
        mediaType,
        parametersInPath: data.parameters?.filter((p) => p.in === "path") || [],
      };

      if (controllersRoutes[controllerName]) {
        controllersRoutes[controllerName].push({ [route]: routeInfo });
      } else {
        controllersRoutes[controllerName] = [{ [route]: routeInfo }];
      }
    }
  });

  return controllersRoutes;
};

// for example 1 | 2 | 3[] should be (1 | 2 | 3)[]
export const handleMultiItemsArrow = (result: string) => {
  const multiItems = result.split(" | ").length > 1;
  if (multiItems) return `(${result})`;
  return result;
};
