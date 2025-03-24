import * as fs from "fs";
import * as path from "path";

import { TRouteInfo } from "../types/fetch-swagger-data.types.js";
import {
  toCamelCase,
  convertToKebabCase,
  getApiNameFromRoute,
  handleResponseInApi,
  handleParameterInPathForApi,
  handleParameterInQueryAndBodyForApi,
} from "../helpers/fetch-swagger-data.helpers.js";

const generateAxios = ({
  controllerName,
  controllerDir,
  routesInfo,
  getControllerFuncFromSettings,
  apiNameConverter,
  enableConfig,
}: {
  controllerName: string;
  controllerDir: string;
  routesInfo: TRouteInfo[];
  getControllerFuncFromSettings: string | undefined;
  apiNameConverter: string;
  enableConfig: boolean;
}) => {
  const folderName = convertToKebabCase(controllerName);

  const filePath = path.join(
    controllerDir,
    `${convertToKebabCase(controllerName)}.api.ts`
  );

  let content = `import ApiInstance from "@api-instance";${
    enableConfig ? `\nimport { AxiosRequestConfig } from "axios";` : ""
  }

import ${toCamelCase(
    controllerName
  )}ApiRoutes from "./${folderName}.api-routes";\n`;

  const interfacesToImport: string[] = [];

  let routeFlag: { [route: string]: boolean } = {};

  routesInfo.forEach((routeInfo) => {
    const [route, info] = Object.entries(routeInfo)[0];
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
    content += `import {\n\t${interfacesToImport.join(
      ",\n\t"
    )}\n} from "./${folderName}.interface";\n`;
  }

  content +=
    "\n// ----------------------------------------------------------------------\n\n";

  routesInfo.forEach((routeInfo) => {
    const [route, info] = Object.entries(routeInfo)[0];

    let apiName = getApiNameFromRoute(
      route,
      false,
      getControllerFuncFromSettings,
      apiNameConverter
    );
    let apiNameWithController = getApiNameFromRoute(
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

    if (apiName !== apiNameWithController) {
      let j = 1;
      while (routeFlag[apiNameWithController]) {
        apiNameWithController = `${apiNameWithController}${j}`;
        j++;
      }
      routeFlag[apiNameWithController] = true;
    }

    content += `const ${toCamelCase(apiName)} = async (${
      info.hasPathParams || info.hasQueryParams || info.hasBodyPayload
        ? `payload: I${apiNameWithController}Request${
            enableConfig ? `, axiosConfig?: AxiosRequestConfig` : ``
          }`
        : enableConfig
        ? "axiosConfig?: AxiosRequestConfig"
        : ""
    }) => {
  const { data } = await ApiInstance.${info.methodType}${handleResponseInApi(
      info.hasResponse,
      apiNameWithController
    )}(\n\t\t${handleParameterInPathForApi(
      `${toCamelCase(controllerName)}ApiRoutes.${apiName}`,
      info.hasPathParams
    )},${enableConfig ? `\n\t\t` : ``}${handleParameterInQueryAndBodyForApi(
      info.hasQueryParams,
      info.hasBodyPayload,
      info.isArrayBodyPayload,
      info.methodType,
      enableConfig
    )}\n\t);
  return data;
};\n\n`;
  });

  routeFlag = {};

  content +=
    "// ----------------------------------------------------------------------\n\n";

  content += `const ${toCamelCase(controllerName)}Api = {\n`;

  const apisToExport: string[] = [];

  routesInfo.forEach((routeInfo) => {
    const route = Object.keys(routeInfo)[0];
    let apiName = getApiNameFromRoute(
      route,
      false,
      getControllerFuncFromSettings,
      apiNameConverter
    );

    let i = 1;
    while (routeFlag[apiName]) {
      apiName = `${apiName}${i}`;
      i++;
    }
    routeFlag[apiName] = true;

    apisToExport.push(toCamelCase(apiName));
  });

  apisToExport.sort((a, b) => a.length - b.length);

  if (apisToExport.length) {
    content += `\t${apisToExport.join(",\n\t")}\n}\n\n`;
  }

  content +=
    "// ----------------------------------------------------------------------\n\n";

  content += `export default ${toCamelCase(controllerName)}Api;`;

  fs.writeFileSync(filePath, content);
};

const generateFetch = ({
  controllerName,
  controllerDir,
  routesInfo,
  getControllerFuncFromSettings,
  apiNameConverter,
  enableConfig,
}: {
  controllerName: string;
  controllerDir: string;
  routesInfo: TRouteInfo[];
  getControllerFuncFromSettings: string | undefined;
  apiNameConverter: string;
  enableConfig: boolean;
}) => {
  const folderName = convertToKebabCase(controllerName);

  const filePath = path.join(
    controllerDir,
    `${convertToKebabCase(controllerName)}.api.ts`
  );

  const withHelpersFile = routesInfo.some((routeInfo) => {
    const [route, info] = Object.entries(routeInfo)[0];
    return info.hasQueryParams;
  });

  let content = `import ApiInstance from "@api-instance";\n\n`;

  if (withHelpersFile) {
    content += `import { prepareQueryParams } from "../helpers";\n`;
  }

  content += `import ${toCamelCase(
    controllerName
  )}ApiRoutes from "./${folderName}.api-routes";\n`;

  const interfacesToImport: string[] = [];
  let routeFlag: { [route: string]: boolean } = {};

  routesInfo.forEach((routeInfo) => {
    const [route, info] = Object.entries(routeInfo)[0];
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
    content += `import {\n\t${interfacesToImport.join(
      ",\n\t"
    )}\n} from "./${folderName}.interface";\n`;
  }

  content +=
    "\n// ----------------------------------------------------------------------\n\n";

  routesInfo.forEach((routeInfo) => {
    const [route, info] = Object.entries(routeInfo)[0];

    let apiName = getApiNameFromRoute(
      route,
      false,
      getControllerFuncFromSettings,
      apiNameConverter
    );
    let apiNameWithController = getApiNameFromRoute(
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

    if (apiName !== apiNameWithController) {
      let j = 1;
      while (routeFlag[apiNameWithController]) {
        apiNameWithController = `${apiNameWithController}${j}`;
        j++;
      }
      routeFlag[apiNameWithController] = true;
    }

    content += `const ${toCamelCase(apiName)} = async (${
      info.hasPathParams || info.hasQueryParams || info.hasBodyPayload
        ? `payload: I${apiNameWithController}Request${
            enableConfig ? `, fetchConfig?: RequestInit` : ""
          }`
        : enableConfig
        ? "fetchConfig?: RequestInit"
        : ""
    })${
      info.hasResponse ? `: Promise<I${apiNameWithController}Response>` : ``
    } => {\n`;

    content += `  const response = await ApiInstance${
      info.hasResponse ? `<I${apiNameWithController}Response>` : ""
    }(${info.hasQueryParams ? "`${" : ""}${handleParameterInPathForApi(
      `${toCamelCase(controllerName)}ApiRoutes.${apiName}`,
      info.hasPathParams
    )}${info.hasQueryParams ? "}" : ""}${
      info.hasQueryParams ? "?${prepareQueryParams(payload.queryParams)}" : ""
    }${info.hasQueryParams ? "`" : ""}, {
    ${enableConfig ? `...fetchConfig,\n` : ""}method: '${info.methodType}',
    headers: {
      'Content-Type': '${info.mediaType}',${
      enableConfig ? `\n      ...fetchConfig?.headers,` : ""
    }
    },${
      info.hasBodyPayload
        ? `\n    body: JSON.stringify(payload.bodyPayload),`
        : ""
    }
  });\n`;

    content += `  return response;\n};\n\n`;
  });
  routeFlag = {};

  content +=
    "// ----------------------------------------------------------------------\n\n";

  content += `const ${toCamelCase(controllerName)}Api = {\n`;

  const apisToExport: string[] = [];

  routesInfo.forEach((routeInfo) => {
    const route = Object.keys(routeInfo)[0];
    let apiName = getApiNameFromRoute(
      route,
      false,
      getControllerFuncFromSettings,
      apiNameConverter
    );

    let i = 1;
    while (routeFlag[apiName]) {
      apiName = `${apiName}${i}`;
      i++;
    }
    routeFlag[apiName] = true;

    apisToExport.push(toCamelCase(apiName));
  });

  apisToExport.sort((a, b) => a.length - b.length);

  if (apisToExport.length) {
    content += `\t${apisToExport.join(",\n\t")}\n}\n\n`;
  }

  content +=
    "// ----------------------------------------------------------------------\n\n";

  content += `export default ${toCamelCase(controllerName)}Api;`;

  fs.writeFileSync(filePath, content);
};
const generateApiFile = ({
  controllerName,
  controllerDir,
  routesInfo,
  getControllerFuncFromSettings,
  apiNameConverter,
  dataFetcher,
  enableConfig,
}: {
  controllerName: string;
  controllerDir: string;
  routesInfo: TRouteInfo[];
  getControllerFuncFromSettings: string | undefined;
  apiNameConverter: string;
  dataFetcher: string;
  enableConfig: boolean;
}) => {
  if (dataFetcher === "axios") {
    generateAxios({
      routesInfo,
      enableConfig,
      controllerDir,
      controllerName,
      apiNameConverter,
      getControllerFuncFromSettings,
    });
  } else {
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

export default generateApiFile;
