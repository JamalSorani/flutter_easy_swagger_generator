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
const fs = __importStar(require("fs"));
const path = __importStar(require("path"));
const fetch_swagger_data_helpers_js_1 = require("../helpers/fetch-swagger-data.helpers.js");
const generateAxios = ({ controllerName, controllerDir, routesInfo, getControllerFuncFromSettings, apiNameConverter, enableConfig, }) => {
    const folderName = (0, fetch_swagger_data_helpers_js_1.convertToKebabCase)(controllerName);
    const filePath = path.join(controllerDir, `${(0, fetch_swagger_data_helpers_js_1.convertToKebabCase)(controllerName)}.api.ts`);
    let content = `import ApiInstance from "@api-instance";${enableConfig ? `\nimport { AxiosRequestConfig } from "axios";` : ""}

import ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}ApiRoutes from "./${folderName}.api-routes";\n`;
    const interfacesToImport = [];
    let routeFlag = {};
    routesInfo.forEach((routeInfo) => {
        const [route, info] = Object.entries(routeInfo)[0];
        let apiName = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, true, getControllerFuncFromSettings, apiNameConverter);
        let i = 1;
        while (routeFlag[apiName]) {
            apiName = `${apiName}${i}`;
            i++;
        }
        routeFlag[apiName] = true;
        if (info.hasQueryParams || info.hasBodyPayload || info.hasPathParams) {
            interfacesToImport.push(`I${apiName}Request`);
        }
        if (info.hasResponse) {
            interfacesToImport.push(`I${apiName}Response`);
        }
    });
    interfacesToImport.sort((a, b) => a.length - b.length);
    routeFlag = {};
    if (interfacesToImport.length) {
        content += `import {\n\t${interfacesToImport.join(",\n\t")}\n} from "./${folderName}.interface";\n`;
    }
    content +=
        "\n// ----------------------------------------------------------------------\n\n";
    routesInfo.forEach((routeInfo) => {
        const [route, info] = Object.entries(routeInfo)[0];
        let apiName = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, false, getControllerFuncFromSettings, apiNameConverter);
        let apiNameWithController = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, true, getControllerFuncFromSettings, apiNameConverter);
        let i = 1;
        while (routeFlag[apiName]) {
            apiName = `${apiName}${i}`;
            i++;
        }
        routeFlag[apiName] = true;
        if (apiName !== apiNameWithController) {
            let j = 1;
            while (routeFlag[apiNameWithController]) {
                apiNameWithController = `${apiNameWithController}${j}`;
                j++;
            }
            routeFlag[apiNameWithController] = true;
        }
        content += `const ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(apiName)} = async (${info.hasPathParams || info.hasQueryParams || info.hasBodyPayload
            ? `payload: I${apiNameWithController}Request${enableConfig ? `, axiosConfig?: AxiosRequestConfig` : ``}`
            : enableConfig
                ? "axiosConfig?: AxiosRequestConfig"
                : ""}) => {
  const { data } = await ApiInstance.${info.methodType}${(0, fetch_swagger_data_helpers_js_1.handleResponseInApi)(info.hasResponse, apiNameWithController)}(\n\t\t${(0, fetch_swagger_data_helpers_js_1.handleParameterInPathForApi)(`${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}ApiRoutes.${apiName}`, info.hasPathParams)},${enableConfig ? `\n\t\t` : ``}${(0, fetch_swagger_data_helpers_js_1.handleParameterInQueryAndBodyForApi)(info.hasQueryParams, info.hasBodyPayload, info.isArrayBodyPayload, info.methodType, enableConfig)}\n\t);
  return data;
};\n\n`;
    });
    routeFlag = {};
    content +=
        "// ----------------------------------------------------------------------\n\n";
    content += `const ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}Api = {\n`;
    const apisToExport = [];
    routesInfo.forEach((routeInfo) => {
        const route = Object.keys(routeInfo)[0];
        let apiName = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, false, getControllerFuncFromSettings, apiNameConverter);
        let i = 1;
        while (routeFlag[apiName]) {
            apiName = `${apiName}${i}`;
            i++;
        }
        routeFlag[apiName] = true;
        apisToExport.push((0, fetch_swagger_data_helpers_js_1.toCamelCase)(apiName));
    });
    apisToExport.sort((a, b) => a.length - b.length);
    if (apisToExport.length) {
        content += `\t${apisToExport.join(",\n\t")}\n}\n\n`;
    }
    content +=
        "// ----------------------------------------------------------------------\n\n";
    content += `export default ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}Api;`;
    fs.writeFileSync(filePath, content);
};
const generateFetch = ({ controllerName, controllerDir, routesInfo, getControllerFuncFromSettings, apiNameConverter, enableConfig, }) => {
    const folderName = (0, fetch_swagger_data_helpers_js_1.convertToKebabCase)(controllerName);
    const filePath = path.join(controllerDir, `${(0, fetch_swagger_data_helpers_js_1.convertToKebabCase)(controllerName)}.api.ts`);
    const withHelpersFile = routesInfo.some((routeInfo) => {
        const [route, info] = Object.entries(routeInfo)[0];
        return info.hasQueryParams;
    });
    let content = `import ApiInstance from "@api-instance";\n\n`;
    if (withHelpersFile) {
        content += `import { prepareQueryParams } from "../helpers";\n`;
    }
    content += `import ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}ApiRoutes from "./${folderName}.api-routes";\n`;
    const interfacesToImport = [];
    let routeFlag = {};
    routesInfo.forEach((routeInfo) => {
        const [route, info] = Object.entries(routeInfo)[0];
        let apiName = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, true, getControllerFuncFromSettings, apiNameConverter);
        let i = 1;
        while (routeFlag[apiName]) {
            apiName = `${apiName}${i}`;
            i++;
        }
        routeFlag[apiName] = true;
        if (info.hasQueryParams || info.hasBodyPayload || info.hasPathParams) {
            interfacesToImport.push(`I${apiName}Request`);
        }
        if (info.hasResponse) {
            interfacesToImport.push(`I${apiName}Response`);
        }
    });
    interfacesToImport.sort((a, b) => a.length - b.length);
    routeFlag = {};
    if (interfacesToImport.length) {
        content += `import {\n\t${interfacesToImport.join(",\n\t")}\n} from "./${folderName}.interface";\n`;
    }
    content +=
        "\n// ----------------------------------------------------------------------\n\n";
    routesInfo.forEach((routeInfo) => {
        const [route, info] = Object.entries(routeInfo)[0];
        let apiName = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, false, getControllerFuncFromSettings, apiNameConverter);
        let apiNameWithController = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, true, getControllerFuncFromSettings, apiNameConverter);
        let i = 1;
        while (routeFlag[apiName]) {
            apiName = `${apiName}${i}`;
            i++;
        }
        routeFlag[apiName] = true;
        if (apiName !== apiNameWithController) {
            let j = 1;
            while (routeFlag[apiNameWithController]) {
                apiNameWithController = `${apiNameWithController}${j}`;
                j++;
            }
            routeFlag[apiNameWithController] = true;
        }
        content += `const ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(apiName)} = async (${info.hasPathParams || info.hasQueryParams || info.hasBodyPayload
            ? `payload: I${apiNameWithController}Request${enableConfig ? `, fetchConfig?: RequestInit` : ""}`
            : enableConfig
                ? "fetchConfig?: RequestInit"
                : ""})${info.hasResponse ? `: Promise<I${apiNameWithController}Response>` : ``} => {\n`;
        content += `  const response = await ApiInstance${info.hasResponse ? `<I${apiNameWithController}Response>` : ""}(${info.hasQueryParams ? "`${" : ""}${(0, fetch_swagger_data_helpers_js_1.handleParameterInPathForApi)(`${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}ApiRoutes.${apiName}`, info.hasPathParams)}${info.hasQueryParams ? "}" : ""}${info.hasQueryParams ? "?${prepareQueryParams(payload.queryParams)}" : ""}${info.hasQueryParams ? "`" : ""}, {
    ${enableConfig ? `...fetchConfig,\n` : ""}method: '${info.methodType}',
    headers: {
      'Content-Type': '${info.mediaType}',${enableConfig ? `\n      ...fetchConfig?.headers,` : ""}
    },${info.hasBodyPayload
            ? `\n    body: JSON.stringify(payload.bodyPayload),`
            : ""}
  });\n`;
        content += `  return response;\n};\n\n`;
    });
    routeFlag = {};
    content +=
        "// ----------------------------------------------------------------------\n\n";
    content += `const ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}Api = {\n`;
    const apisToExport = [];
    routesInfo.forEach((routeInfo) => {
        const route = Object.keys(routeInfo)[0];
        let apiName = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, false, getControllerFuncFromSettings, apiNameConverter);
        let i = 1;
        while (routeFlag[apiName]) {
            apiName = `${apiName}${i}`;
            i++;
        }
        routeFlag[apiName] = true;
        apisToExport.push((0, fetch_swagger_data_helpers_js_1.toCamelCase)(apiName));
    });
    apisToExport.sort((a, b) => a.length - b.length);
    if (apisToExport.length) {
        content += `\t${apisToExport.join(",\n\t")}\n}\n\n`;
    }
    content +=
        "// ----------------------------------------------------------------------\n\n";
    content += `export default ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}Api;`;
    fs.writeFileSync(filePath, content);
};
const generateApiFile = ({ controllerName, controllerDir, routesInfo, getControllerFuncFromSettings, apiNameConverter, dataFetcher, enableConfig, }) => {
    if (dataFetcher === "axios") {
        generateAxios({
            routesInfo,
            enableConfig,
            controllerDir,
            controllerName,
            apiNameConverter,
            getControllerFuncFromSettings,
        });
    }
    else {
        generateFetch({
            routesInfo,
            enableConfig,
            controllerDir,
            controllerName,
            apiNameConverter,
            getControllerFuncFromSettings,
        });
    }
};
exports.default = generateApiFile;
