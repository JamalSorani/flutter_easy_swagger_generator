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
const generateRouteFile = ({ controllerDir, controllerName, routes, getControllerFuncFromSettings, apiNameConverter, }) => {
    const filePath = path.join(controllerDir, `${(0, fetch_swagger_data_helpers_js_1.convertToKebabCase)(controllerName)}.api-routes.ts`);
    let content = `const ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}ApiRoutes = {\n`;
    const routeFlag = {};
    routes.forEach((routeInfo) => {
        const [route, info] = Object.entries(routeInfo)[0];
        let apiName = (0, fetch_swagger_data_helpers_js_1.getApiNameFromRoute)(route, false, getControllerFuncFromSettings, apiNameConverter);
        let i = 1;
        while (routeFlag[apiName]) {
            apiName = `${apiName}${i}`;
            i++;
        }
        routeFlag[apiName] = true;
        content += `\t${apiName}: ${(0, fetch_swagger_data_helpers_js_1.handleParameterInPath)(route, info.parametersInPath)},\n`;
    });
    content += `};\n`;
    content += `
export default ${(0, fetch_swagger_data_helpers_js_1.toCamelCase)(controllerName)}ApiRoutes;`;
    fs.writeFileSync(filePath, content);
};
exports.default = generateRouteFile;
