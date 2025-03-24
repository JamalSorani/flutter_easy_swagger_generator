import generateApiFile from "./generators/apis-file-generator.js";
import generateRouteFile from "./generators/routes-file-generator.js";
import openApiJsonToInterface from "./generators/interfaces-file-generator.js";
import {
  convertToKebabCase,
  fetchSwaggerJson,
  prepareControllersRoutes,
  readConfig,
} from "./helpers/fetch-swagger-data.helpers.js";
import { TRouteInfo } from "./types/fetch-swagger-data.types.js";
import * as fs from "fs";
import * as path from "path";

const configPath = "openapi-v3-typescript-config.json";

const [controllerNameToGenerate] = process.argv.slice(2);

const {
  input: inputSource,
  output = "openapi-v3-typescript",
  apis = {
    enable: true,
    dataFetcher: "axios",
    enableConfig: true,
  },
  reactQuery = {
    enable: true,
    pageParam: "pageParam",
    getNextPageParam: `(lastPage, allPages) => {\n\t\t\tif (!lastPage?.hasNextPage) return undefined;\n\t\t\treturn allPages.length;\n\t}`,
    enableConfig: true,
  },
  getControllerNameFromRoute:
    getControllerFuncFromSettings = `(route) => route.split('/')[2]`,
  interfaceNameConverter,
  apiNameConverter,
  includedControllers,
  excludedControllers,
  nullSafety,
} = readConfig(configPath);

const outputLocation = process.cwd() + "/" + output;

let reactQueryPageParam = reactQuery.pageParam || [];
if (typeof reactQueryPageParam === "string" && reactQueryPageParam.length)
  reactQueryPageParam = [reactQueryPageParam];

// ----------------------------------------------------------------------

function generateController({
  controllerName,
  routesInfo,
}: {
  controllerName: string;
  routesInfo: TRouteInfo[];
}) {
  const controllerDir = `${outputLocation}/${convertToKebabCase(
    controllerName
  )}`;

  fs.mkdirSync(controllerDir, { recursive: true });

  if (apis.enable) {
    generateRouteFile({
      controllerDir,
      controllerName,
      routes: routesInfo,
      getControllerFuncFromSettings,
      apiNameConverter,
    });
    generateApiFile({
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
    const openApiJson = await fetchSwaggerJson({ inputSource });
    const { paths } = openApiJson;

    const helpersPath = path.join(outputLocation, `helpers.ts`);

    const controllersRoutes = prepareControllersRoutes({
      paths,
      excludedControllers,
      includedControllers,
      reactQueryPageParam,
      controllerNameToGenerate,
      getControllerFuncFromSettings,
    });

    Object.entries(controllersRoutes).forEach(
      ([controllerName, routesInfo]) => {
        generateController({
          controllerName,
          routesInfo,
        });
      }
    );

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

    openApiJsonToInterface(
      openApiJson,
      outputLocation,
      getControllerFuncFromSettings,
      includedControllers,
      excludedControllers,
      interfaceNameConverter,
      apiNameConverter,
      nullSafety
    );
  } catch (error) {
    console.error("Error fetching or processing Swagger JSON:", error);
  }
}

main();

// ----------------------------------------------------------------------
