import {
  convertToKebabCase,
  getApiNameFromRoute,
  handleParameterInPath,
  toCamelCase,
} from "../helpers/fetch-swagger-data.helpers.js";

import * as fs from "fs";
import * as path from "path";
import { TRouteInfo } from "../types/fetch-swagger-data.types.js";

const generateRouteFile = ({
  controllerDir,
  controllerName,
  routes,
  getControllerFuncFromSettings,
  apiNameConverter,
}: {
  controllerDir: string;
  controllerName: string;
  routes: TRouteInfo[];
  getControllerFuncFromSettings: string | undefined;
  apiNameConverter: string;
}) => {
  const filePath = path.join(
    controllerDir,
    `${convertToKebabCase(controllerName)}.api-routes.ts`
  );
  let content = `const ${toCamelCase(controllerName)}ApiRoutes = {\n`;

  const routeFlag: { [key: string]: boolean } = {};

  routes.forEach((routeInfo) => {
    const [route, info] = Object.entries(routeInfo)[0];
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

    content += `\t${apiName}: ${handleParameterInPath(
      route,
      info.parametersInPath
    )},\n`;
  });

  content += `};\n`;

  content += `
export default ${toCamelCase(controllerName)}ApiRoutes;`;

  fs.writeFileSync(filePath, content);
};

export default generateRouteFile;
