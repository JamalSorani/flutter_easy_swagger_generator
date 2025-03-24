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
exports.handleMultiItemsArrow = exports.prepareControllersRoutes = exports.allowGenerateController = exports.writeConfig = exports.readConfig = exports.isArrayProperty = exports.isObjectProperty = exports.isRefProperty = exports.isNumberProperty = exports.isPrimitiveProperty = exports.getControllerNameFromRoute = exports.getApiNameFromRoute = exports.handleResponseInApi = exports.handleParameterInQueryAndBodyForApi = exports.handleParameterInPathForApi = exports.handleParameterInPath = exports.dtoNameToInterfaceName = exports.applyAnd = exports.applyOr = exports.nullable = exports.appendNewLine = exports.convertToKebabCase = exports.toCamelCase = exports.getFileDtos = void 0;
exports.fetchSwaggerJson = fetchSwaggerJson;
const fs = __importStar(require("fs"));
const path = __importStar(require("path"));
// ----------------------------------------------------------------------
const getFileDtos = (fileResult) => fileResult
    .split("\n")
    .map((el) => el.startsWith("\t[key: string]:")
    ? el.split("\t[key: string]:")[1]
    : el.split(/[:=]/)[1])
    .filter(Boolean)
    .map((el) => el.split(";")[0].replaceAll("[]", "").replaceAll(" | null", "").trim())
    .filter((el) => el !== "{" && !["boolean", "number", "string"].includes(el));
exports.getFileDtos = getFileDtos;
const toCamelCase = (str) => str
    .replace(/([A-Z])/g, "_$1")
    .toLowerCase()
    .replace(/^_/, "")
    .replace(/_./g, (match) => match[1].toUpperCase());
exports.toCamelCase = toCamelCase;
const convertToKebabCase = (input) => {
    const kebabCase = input
        .replace(/([a-z])([A-Z])/g, "$1-$2")
        .replace(/([A-Z]+)/g, "-$1")
        .toLowerCase();
    return (kebabCase.startsWith("-") ? kebabCase.slice(1) : kebabCase).replaceAll("--", "-");
};
exports.convertToKebabCase = convertToKebabCase;
const appendNewLine = (isPropertyOfArray) => isPropertyOfArray ? "" : ";\n";
exports.appendNewLine = appendNewLine;
const nullable = (property, nullSafety) => `${property.nullable &&
    (nullSafety === true || nullSafety?.toString() === "true")
    ? " | null"
    : ""}`;
exports.nullable = nullable;
const applyOr = (array) => array.join(" | ");
exports.applyOr = applyOr;
const applyAnd = (array) => array.join(" & ");
exports.applyAnd = applyAnd;
const dtoNameToInterfaceName = (dtoName, interfaceNameConverter) => {
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
exports.dtoNameToInterfaceName = dtoNameToInterfaceName;
const handleParameterInPath = (route, parametersInPath) => {
    if (route.includes("{")) {
        return `(${route
            .match(/{[^}]*}/g)
            ?.map((el) => `${el}: ${parametersInPath.find((p) => p.name === el.slice(1, -1))?.schema
            ?.type || "number | string"}`)
            ?.join(`, `)
            .replaceAll("{", "")
            .replaceAll("}", "")}) => ${`\`${route.replaceAll("{", "${")}\``}`;
    }
    return `'${route}'`;
};
exports.handleParameterInPath = handleParameterInPath;
const handleParameterInPathForApi = (apiName, hasPathParams) => {
    if (hasPathParams) {
        return `${apiName}(...payload.pathParams)`;
    }
    return apiName;
};
exports.handleParameterInPathForApi = handleParameterInPathForApi;
const handleParameterInQueryAndBodyForApi = (hasQueryParams, hasBodyPayload, isArrayBodyPayload, methodType, enableConfig) => {
    const queryParams = enableConfig
        ? `\n      params: {
        ...payload.queryParams,
        ...axiosConfig?.params,
      },\n`
        : `\n      params: payload.queryParams\n`;
    const axiosConfig = enableConfig ? `\n      ...axiosConfig,` : ``;
    const bodyPayload = enableConfig
        ? `${!hasQueryParams ? `\n` : ""}      data: ${isArrayBodyPayload
            ? `[...payload.bodyPayload, ...(axiosConfig?.data||[])],`
            : `{
        ...payload.bodyPayload,
        ...axiosConfig?.data,
      }`}\n`
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
exports.handleParameterInQueryAndBodyForApi = handleParameterInQueryAndBodyForApi;
const handleResponseInApi = (hasResponse, apiName) => {
    if (hasResponse) {
        return `<I${apiName}Response>`;
    }
    return "";
};
exports.handleResponseInApi = handleResponseInApi;
const getApiNameFromRoute = (route, withController, getControllerNameFromRouteFn, apiNameConverter) => {
    const controller = (0, exports.getControllerNameFromRoute)(route, getControllerNameFromRouteFn, false);
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
        .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
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
exports.getApiNameFromRoute = getApiNameFromRoute;
const fixCpapCaseMethod = (s) => s
    .replace(/-/g, " ")
    .split(" ")
    .map((w) => w.charAt(0).toUpperCase() + w.slice(1))
    .join("");
const getControllerNameFromRoute = (route, funcFromSettings, fixCpapCase) => {
    if (funcFromSettings) {
        if (eval(funcFromSettings)(route) === null)
            return null;
        return fixCpapCase
            ? fixCpapCaseMethod(eval(funcFromSettings)(route))
            : eval(funcFromSettings)(route);
    }
    return route.split("/")[2];
};
exports.getControllerNameFromRoute = getControllerNameFromRoute;
// ----------------------------------------------------------------------
const isPrimitiveProperty = (property) => {
    if (!property.type) {
        return false;
    }
    let type = property.type;
    if (Array.isArray(type))
        type = type[0];
    const primitiveTypes = [
        "number",
        "integer",
        "string",
        "boolean",
    ];
    return primitiveTypes.includes(type);
};
exports.isPrimitiveProperty = isPrimitiveProperty;
const isNumberProperty = (property) => {
    if (!property.type) {
        return false;
    }
    const primitiveTypes = ["number", "integer"];
    return primitiveTypes.includes(property.type);
};
exports.isNumberProperty = isNumberProperty;
const isRefProperty = (property) => !property.type && !!property.$ref;
exports.isRefProperty = isRefProperty;
const isObjectProperty = (property) => property.type === "object";
exports.isObjectProperty = isObjectProperty;
const isArrayProperty = (property) => property.type === "array";
exports.isArrayProperty = isArrayProperty;
const readConfig = (configPath) => {
    try {
        const configFile = fs.readFileSync(configPath, "utf8");
        return JSON.parse(configFile);
    }
    catch (error) {
        console.error(`Error reading config file: ${error.message}`);
        process.exit(1);
    }
};
exports.readConfig = readConfig;
// Modify the configuration (add or update properties)
// configFile.newProperty = "New Value"; // Add a new property
// configFile.existingProperty = "Updated Value"; // Update an existing property
// Write the updated configuration back to the file
// writeConfig(configFile);
const writeConfig = (configFile) => {
    try {
        fs.writeFileSync(configFile, JSON.stringify(configFile, null, 2), "utf8");
    }
    catch (error) {
        console.error(`Error writing to config file: ${error.message}`);
        process.exit(1);
    }
};
exports.writeConfig = writeConfig;
const allowGenerateController = ({ controllerName, controllerNameToGenerate, includedControllers, excludedControllers, }) => {
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
exports.allowGenerateController = allowGenerateController;
async function fetchSwaggerJson({ inputSource, }) {
    if (inputSource.endsWith(".js")) {
        if (inputSource.startsWith("http://") ||
            inputSource.startsWith("https://")) {
            // Fetch data from the URL
            try {
                const response = await fetch(inputSource);
                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }
                const file = await response.text();
                const paths = file
                    .slice(file.indexOf('    "paths": {'), file.indexOf(`,
    "info": {`))
                    .trim();
                const components = file
                    .slice(file.indexOf('    "components": {'), file.indexOf(`,
  "customOptions": {`))
                    .trim()
                    .slice(0, -1)
                    .trim();
                return JSON.parse(`{
          ${paths},
          ${components}
        }`);
            }
            catch (error) {
                console.error("Error fetching data from URL:", error);
                throw error; // Rethrow or handle as needed
            }
        }
        else {
            // Read data from the JSON file
            const resolvedInputSource = path.resolve(inputSource);
            return new Promise((resolve, reject) => {
                fs.readFile(resolvedInputSource, "utf8", (err, data) => {
                    if (err) {
                        console.error(`Error reading file from ${resolvedInputSource}:`, err);
                        return reject(err);
                    }
                    try {
                        const file = data;
                        const paths = JSON.parse(file
                            .slice(file.indexOf("paths"), file.indexOf("info"))
                            .trim()
                            .slice(-1));
                        const components = JSON.parse(file
                            .slice(file.indexOf("components"), file.indexOf("customOptions"))
                            .trim()
                            .slice(-2));
                        return {
                            paths,
                            components,
                        };
                    }
                    catch (parseError) {
                        console.error("Error parsing JSON data:", parseError);
                        return reject(parseError);
                    }
                });
            });
        }
    }
    else if (inputSource.startsWith("http://") ||
        inputSource.startsWith("https://")) {
        // Fetch data from the URL
        try {
            const response = await fetch(inputSource);
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const jsonData = await response.json();
            return jsonData;
        }
        catch (error) {
            console.error("Error fetching data from URL:", error);
            throw error; // Rethrow or handle as needed
        }
    }
    else {
        // Read data from the JSON file
        const resolvedInputSource = path.resolve(inputSource);
        return new Promise((resolve, reject) => {
            fs.readFile(resolvedInputSource, "utf8", (err, data) => {
                if (err) {
                    console.error(`Error reading file from ${resolvedInputSource}:`, err);
                    return reject(err);
                }
                try {
                    const jsonData = JSON.parse(data);
                    return resolve(jsonData);
                }
                catch (parseError) {
                    console.error("Error parsing JSON data:", parseError);
                    return reject(parseError);
                }
            });
        });
    }
}
const prepareControllersRoutes = ({ paths, getControllerFuncFromSettings, controllerNameToGenerate, excludedControllers, includedControllers, reactQueryPageParam, }) => {
    const controllersRoutes = {};
    Object.entries(paths).forEach(([route, methods]) => {
        const controllerName = (0, exports.getControllerNameFromRoute)(route, getControllerFuncFromSettings, true); // Use the first segment as controller name
        if ((0, exports.allowGenerateController)({
            controllerName,
            controllerNameToGenerate,
            excludedControllers,
            includedControllers,
        })) {
            const [methodType, data] = Object.entries(methods)[0];
            let hasBodyPayload = false;
            let isArrayBodyPayload = false;
            let hasResponse = false;
            let hasPageParamInQuery = data.parameters
                ?.filter((p) => p.in === "query" && reactQueryPageParam.includes(p.name))
                .map((el) => el.name) || [];
            let hasPageParamInBody = [];
            if (data.requestBody?.content) {
                hasBodyPayload = !!Object.values(data.requestBody?.content)[0]?.schema;
                const requestProperty = Object.values(data.requestBody?.content)[0]
                    ?.schema;
                isArrayBodyPayload = (0, exports.isArrayProperty)(Object.values(data.requestBody?.content)[0]?.schema);
                hasPageParamInBody =
                    (0, exports.isObjectProperty)(requestProperty) && !!requestProperty.properties
                        ? Object.keys(requestProperty.properties).filter((k) => reactQueryPageParam.includes(k))
                        : [];
            }
            let mediaType = "application/json";
            if (data.responses?.[200]?.content) {
                hasResponse = !!Object.values(data.responses?.[200]?.content)[0]
                    ?.schema;
                mediaType = Object.keys(data.responses?.[200]?.content)[0];
            }
            const routeInfo = {
                hasBodyPayload,
                isArrayBodyPayload,
                hasResponse,
                hasPathParams: !!data.parameters?.some((p) => p.in === "path"),
                hasQueryParams: !!data.parameters?.some((p) => p.in === "query"),
                hasPageParamInBody,
                hasPageParamInQuery,
                methodType: methodType,
                mediaType,
                parametersInPath: data.parameters?.filter((p) => p.in === "path") || [],
            };
            if (controllersRoutes[controllerName]) {
                controllersRoutes[controllerName].push({ [route]: routeInfo });
            }
            else {
                controllersRoutes[controllerName] = [{ [route]: routeInfo }];
            }
        }
    });
    return controllersRoutes;
};
exports.prepareControllersRoutes = prepareControllersRoutes;
// for example 1 | 2 | 3[] should be (1 | 2 | 3)[]
const handleMultiItemsArrow = (result) => {
    const multiItems = result.split(" | ").length > 1;
    if (multiItems)
        return `(${result})`;
    return result;
};
exports.handleMultiItemsArrow = handleMultiItemsArrow;
