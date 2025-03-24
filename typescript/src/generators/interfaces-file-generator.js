"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || (function () {
    var ownKeys = function(o) {
        ownKeys = Object.getOwnPropertyNames || function (o) {
            var ar = [];
            for (var k in o) if (Object.prototype.hasOwnProperty.call(o, k)) ar[ar.length] = k;
            return ar;
        };
        return ownKeys(o);
    };
    return function (mod) {
        if (mod && mod.__esModule) return mod;
        var result = {};
        if (mod != null) for (var k = ownKeys(mod), i = 0; i < k.length; i++) if (k[i] !== "default") __createBinding(result, mod, k[i]);
        __setModuleDefault(result, mod);
        return result;
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
const fetch_swagger_data_helpers_js_1 = require("../helpers/fetch-swagger-data.helpers.js");
const fs = __importStar(require("fs"));
const path = __importStar(require("path"));
const [controllerNameToGenerate] = process.argv.slice(2);
const openApiJsonToInterface = (openApiJson, outputLocation, getControllerFuncFromSettings, includedControllers, excludedControllers, interfaceNameConverter, apiNameConverter, nullSafety) => {
    const { paths, components } = openApiJson;
    const dtosInCommon = {}; // dtoName: interfaces
    const interfaces = {}; // {controllerName: controllerInterfaces[]}
    const schemasInterfaces = {};
    let controllerName = "";
    let isPostProcessing = false;
    // ----------------------------------------------------------------------
    // #region preProcessing
    const preProcessing = () => {
        const recGetRef = (property) => {
            if ((0, fetch_swagger_data_helpers_js_1.isRefProperty)(property)) {
                const dtoName = property.$ref.replace("#/components/schemas/", "");
                if (dtosInCommon[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)]) {
                    return;
                }
                dtosInCommon[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(property.$ref.replace("#/components/schemas/", ""), interfaceNameConverter)] = property;
                const data = components.schemas[dtoName];
                recGetRef(data);
                return;
            }
            if ((0, fetch_swagger_data_helpers_js_1.isObjectProperty)(property)) {
                Object.values({
                    ...(property.properties || {}),
                }).forEach(recGetRef);
                if (property.additionalProperties &&
                    property.additionalProperties !== true) {
                    if ((0, fetch_swagger_data_helpers_js_1.isRefProperty)(property.additionalProperties)) {
                        recGetRef(property.additionalProperties);
                    }
                }
                return;
            }
            if ((0, fetch_swagger_data_helpers_js_1.isArrayProperty)(property) && property.items) {
                recGetRef(property.items);
            }
            property.allOf?.filter(fetch_swagger_data_helpers_js_1.isRefProperty).map(recGetRef);
            property.anyOf?.filter(fetch_swagger_data_helpers_js_1.isRefProperty).map(recGetRef);
            property.oneOf?.filter(fetch_swagger_data_helpers_js_1.isRefProperty).map(recGetRef);
            property.allOf?.filter(fetch_swagger_data_helpers_js_1.isObjectProperty).map(recGetRef);
            property.anyOf?.filter(fetch_swagger_data_helpers_js_1.isObjectProperty).map(recGetRef);
            property.oneOf?.filter(fetch_swagger_data_helpers_js_1.isObjectProperty).map(recGetRef);
            property.allOf?.filter(fetch_swagger_data_helpers_js_1.isArrayProperty).map(recGetRef);
            property.anyOf?.filter(fetch_swagger_data_helpers_js_1.isArrayProperty).map(recGetRef);
            property.oneOf?.filter(fetch_swagger_data_helpers_js_1.isArrayProperty).map(recGetRef);
        };
        Object.entries(paths).forEach(([route, obj]) => {
            const [, data] = Object.entries(obj)[0];
            if ((0, fetch_swagger_data_helpers_js_1.allowGenerateController)({
                controllerName: (0, fetch_swagger_data_helpers_js_1.getControllerNameFromRoute)(route, getControllerFuncFromSettings, true),
                controllerNameToGenerate,
                excludedControllers,
                includedControllers,
            })) {
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
    const getRef = (property, isPropertyOfArray, isFirstLevel) => {
        const dtoName = property.$ref.replace("#/components/schemas/", "");
        const data = components.schemas[dtoName];
        if (isPostProcessing) {
            if (schemasInterfaces[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)]) {
                if (isFirstLevel) {
                    return schemasInterfaces[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)];
                }
                return (0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter);
            }
        }
        else if (dtosInCommon[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)] ||
            schemasInterfaces[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)]) {
            return (0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter);
        }
        schemasInterfaces[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)] =
            (0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter);
        schemasInterfaces[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)] =
            getProperty(data, isPropertyOfArray, false);
        if (isPostProcessing) {
            dtosInCommon[controllerName] =
                schemasInterfaces[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)];
            if (isFirstLevel) {
                return schemasInterfaces[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)];
            }
            return (0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter);
        }
        if (property.enum || data.enum) {
            return `${getEnum(property)}`;
        }
        interfaces[controllerName].push(`type ${(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)} = ${schemasInterfaces[(0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter)]}`);
        return (0, fetch_swagger_data_helpers_js_1.dtoNameToInterfaceName)(dtoName, interfaceNameConverter);
    };
    // ----------------------------------------------------------------------
    const getEnum = (property) => {
        if (!property.type && property.$ref) {
            const enumName = property.$ref.replace("#/components/schemas/", "");
            const data = components.schemas[enumName];
            return `${(0, fetch_swagger_data_helpers_js_1.applyOr)(data.enum || [])}`;
        }
        return "''";
    };
    // ----------------------------------------------------------------------
    const getObject = (properties, isPropertyOfArray, additionalProperties) => {
        let content = `\t{\n`;
        if (properties) {
            Object.entries(properties).forEach(([propertyName, p]) => {
                content += `\t"${propertyName}": ${getProperty(p, false, false)}`;
            });
        }
        if (additionalProperties) {
            content += `\t[key: string]: ${getProperty(additionalProperties, isPropertyOfArray, false)}`;
        }
        content += `}`;
        return content;
    };
    // ----------------------------------------------------------------------
    // this function includes "nullable(property)\n;"
    const getProperty = (property, isPropertyOfArray, isFirstLevel) => {
        property.type = Array.isArray(property.type)
            ? property.type?.[0]
            : property.type;
        if (property.enum) {
            return `${(0, fetch_swagger_data_helpers_js_1.applyOr)(property.enum.map((el) => (typeof el === "string" ? `"${el}"` : el)))}${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        if ((0, fetch_swagger_data_helpers_js_1.isPrimitiveProperty)(property)) {
            if ((0, fetch_swagger_data_helpers_js_1.isNumberProperty)(property)) {
                return `number${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
            }
            return `${property.type}${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        if ((0, fetch_swagger_data_helpers_js_1.isArrayProperty)(property)) {
            if (property.items) {
                return `${(0, fetch_swagger_data_helpers_js_1.handleMultiItemsArrow)(getProperty(property.items, true, false))}[]${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
            }
            return `[]${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        if ((0, fetch_swagger_data_helpers_js_1.isObjectProperty)(property)) {
            return `${getObject(property.properties, isPropertyOfArray, property.additionalProperties === true
                ? undefined
                : property.additionalProperties)}${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        if (!property.type &&
            property.$ref === "#/components/schemas/System.TimeSpan") {
            return `string${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        if ((0, fetch_swagger_data_helpers_js_1.isRefProperty)(property)) {
            return `${getRef(property, isPropertyOfArray, isFirstLevel)}${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        if (property.oneOf) {
            return `${(0, fetch_swagger_data_helpers_js_1.applyOr)(property.oneOf.map((p) => getProperty(p, true, false)))}${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        if (property.anyOf) {
            return `${(0, fetch_swagger_data_helpers_js_1.handleMultiItemsArrow)((0, fetch_swagger_data_helpers_js_1.applyOr)(property.anyOf.map((p) => getProperty(p, true, false))))}[]${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        if (property.allOf) {
            return `${(0, fetch_swagger_data_helpers_js_1.applyAnd)(property.allOf.map((p) => getProperty(p, true, false)))}${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        if (property.AnyValue) {
            return `any${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
        }
        return `''${(0, fetch_swagger_data_helpers_js_1.nullable)(property, nullSafety)}${(0, fetch_swagger_data_helpers_js_1.appendNewLine)(isPropertyOfArray)}`;
    };
    // ----------------------------------------------------------------------
    const getQueryParams = (parameters) => {
        let content = `\tqueryParams: {\n`;
        parameters.forEach((parameter) => {
            if (parameter.schema) {
                content += `\t\t"${parameter.name}"${parameter.required ? "" : "?"}: ${getProperty(parameter.schema, false, true)}`;
            }
        });
        content += `\t}\n`;
        return content;
    };
    // ----------------------------------------------------------------------
    const getPathParams = (parameters) => {
        let content = `\tpathParams: [`;
        parameters.forEach((parameter, i) => {
            if (parameter.schema) {
                content += `${parameter.name}${parameter.required ? "" : "?"}: ${getProperty(parameter.schema, true, true)}${i !== parameters.length - 1 ? "," : ""}`;
            }
        });
        content += `]\n;`;
        return content;
    };
    // ----------------------------------------------------------------------
    const getBodyPayload = (requestBody) => {
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
    const getResponsePayload = (response) => {
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
    let routeFlag = {};
    Object.entries(paths).forEach(([route, obj]) => {
        let apiName = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, true, getControllerFuncFromSettings, apiNameConverter);
        let i = 1;
        while (routeFlag[apiName]) {
            apiName = `${apiName}${i}`;
            i++;
        }
        routeFlag[apiName] = true;
        controllerName = (0, fetch_swagger_data_helpers_js_1.getControllerNameFromRoute)(route, getControllerFuncFromSettings, true);
        if ((0, fetch_swagger_data_helpers_js_1.allowGenerateController)({
            controllerName,
            controllerNameToGenerate,
            excludedControllers,
            includedControllers,
        })) {
            if (!interfaces[controllerName]) {
                interfaces[controllerName] = [];
            }
            const [, data] = Object.entries(obj)[0];
            const queryParameters = data.parameters?.filter((p) => p.in === "query");
            const pathParameters = data.parameters?.filter((p) => p.in === "path");
            if (pathParameters?.length ||
                queryParameters?.length ||
                data.requestBody?.content) {
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
        if (!Object.entries(dtosInCommon).length)
            return;
        const fPath = path.join(outputLocation, "common.interface.ts");
        let result = "";
        Object.entries(dtosInCommon).forEach(([dto, prop]) => {
            result += `export type ${dto} = ${typeof prop === "string" ? prop : getProperty(prop, false, true)}\n`;
        });
        fs.writeFileSync(fPath, result.replaceAll(`;\n;`, ";\n").trim());
    };
    const importDtosInCommonAndPrint = () => {
        if (!controllerNameToGenerate) {
            printCommonInterfacesFile();
        }
        Object.entries(interfaces).forEach(([cName, controllerInterfaces]) => {
            if ((0, fetch_swagger_data_helpers_js_1.allowGenerateController)({
                controllerName: cName,
                controllerNameToGenerate,
                excludedControllers,
                includedControllers,
            })) {
                const filePath = path.join(outputLocation, (0, fetch_swagger_data_helpers_js_1.convertToKebabCase)(cName), `${(0, fetch_swagger_data_helpers_js_1.convertToKebabCase)(cName)}.interface.ts`);
                let result = controllerInterfaces.join("\n\n");
                const dtosToImports = [];
                Object.keys(dtosInCommon).forEach((dto) => {
                    if ((0, fetch_swagger_data_helpers_js_1.getFileDtos)(result).some((fileDto) => fileDto.split(" ").some((el) => {
                        return el[0] === "(" && el.at(-1) === ")"
                            ? el.slice(1, -1) === dto
                            : el === dto;
                    }))) {
                        dtosToImports.push(dto);
                    }
                });
                dtosToImports.sort((a, b) => a.length - b.length);
                if (!controllerNameToGenerate) {
                    if (dtosToImports.length) {
                        result = `import {\n\t${dtosToImports.join(",\n\t")}\n} from "../common.interface";\n\n// ----------------------------------------------------------------------\n\n${result}`;
                    }
                }
                else {
                    Object.entries(dtosInCommon).forEach(([dto, prop]) => {
                        result += `export type ${dto} = ${typeof prop === "string" ? prop : getProperty(prop, false, true)}\n`;
                    });
                }
                result = result.replaceAll(`;\n;`, ";\n");
                if (result.length)
                    fs.writeFileSync(filePath, result);
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
exports.default = openApiJsonToInterface;
