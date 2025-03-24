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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const apis_file_generator_js_1 = __importDefault(require("./generators/apis-file-generator.js"));
const routes_file_generator_js_1 = __importDefault(require("./generators/routes-file-generator.js"));
const interfaces_file_generator_js_1 = __importDefault(require("./generators/interfaces-file-generator.js"));
const fetch_swagger_data_helpers_js_1 = require("./helpers/fetch-swagger-data.helpers.js");
const fs = __importStar(require("fs"));
const path = __importStar(require("path"));
const configPath = "openapi-v3-typescript-config.json";
const [controllerNameToGenerate] = process.argv.slice(2);
const { input: inputSource, output = "openapi-v3-typescript", apis = {
    enable: true,
    dataFetcher: "axios",
    enableConfig: true,
}, reactQuery = {
    enable: true,
    pageParam: "pageParam",
    getNextPageParam: `(lastPage, allPages) => {\n\t\t\tif (!lastPage?.hasNextPage) return undefined;\n\t\t\treturn allPages.length;\n\t}`,
    enableConfig: true,
}, getControllerNameFromRoute: getControllerFuncFromSettings = `(route) => route.split('/')[2]`, interfaceNameConverter, apiNameConverter, includedControllers, excludedControllers, nullSafety, } = (0, fetch_swagger_data_helpers_js_1.readConfig)(configPath);
const outputLocation = process.cwd() + "/" + output;
let reactQueryPageParam = reactQuery.pageParam || [];
if (typeof reactQueryPageParam === "string" && reactQueryPageParam.length)
    reactQueryPageParam = [reactQueryPageParam];
// ----------------------------------------------------------------------
function generateController({ controllerName, routesInfo, }) {
    const controllerDir = `${outputLocation}/${(0, fetch_swagger_data_helpers_js_1.convertToKebabCase)(controllerName)}`;
    fs.mkdirSync(controllerDir, { recursive: true });
    if (apis.enable) {
        (0, routes_file_generator_js_1.default)({
            controllerDir,
            controllerName,
            routes: routesInfo,
            getControllerFuncFromSettings,
            apiNameConverter,
        });
        (0, apis_file_generator_js_1.default)({
            controllerDir,
            controllerName,
            routesInfo,
            getControllerFuncFromSettings,
            apiNameConverter,
            dataFetcher: apis.dataFetcher,
            enableConfig: apis.enableConfig,
        });
    }
}
async function main() {
    try {
        const openApiJson = await (0, fetch_swagger_data_helpers_js_1.fetchSwaggerJson)({ inputSource });
        const { paths } = openApiJson;
        const helpersPath = path.join(outputLocation, `helpers.ts`);
        const controllersRoutes = (0, fetch_swagger_data_helpers_js_1.prepareControllersRoutes)({
            paths,
            excludedControllers,
            includedControllers,
            reactQueryPageParam,
            controllerNameToGenerate,
            getControllerFuncFromSettings,
        });
        Object.entries(controllersRoutes).forEach(([controllerName, routesInfo]) => {
            generateController({
                controllerName,
                routesInfo,
            });
        });
        if (apis.dataFetcher === "fetch" && apis.enable) {
            let helpersFileContent = `export const prepareQueryParams = <T extends {}>(queryParams: T) => {
  const params = new URLSearchParams();
  Object.keys(queryParams).forEach((key) => {
    params.append(key, queryParams[key as keyof T]?.toString() || "");
  });
  return params.toString();
};\n\n`;
            helpersFileContent += `export interface FetchResponse<T> extends Response {
  json<T extends any>(): Promise<T>;
}`;
            fs.writeFileSync(helpersPath, helpersFileContent);
        }
        (0, interfaces_file_generator_js_1.default)(openApiJson, outputLocation, getControllerFuncFromSettings, includedControllers, excludedControllers, interfaceNameConverter, apiNameConverter, nullSafety);
    }
    catch (error) {
        console.error("Error fetching or processing Swagger JSON:", error);
    }
}
main();
// ----------------------------------------------------------------------
