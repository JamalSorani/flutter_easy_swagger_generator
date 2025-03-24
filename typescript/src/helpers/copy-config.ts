import * as fs from "fs";
import * as path from "path";

const fullPath = path.dirname(require.main?.filename || "");
const regexResp = /^(.*?)node_modules/.exec(fullPath);
const appRoot = regexResp ? regexResp[1] : fullPath;

const configFilePath = path.join(appRoot, "openapi-v3-typescript-config.json");

const otherWayConfigFilePath = path.join(
  process.cwd(),
  "openapi-v3-typescript-config.json"
);

try {
  if (!fs.existsSync(configFilePath)) {
    fs.copyFileSync(
      "src/templates/openapi-v3-typescript-config.json.template",
      configFilePath
    );
  }
} catch (error) {
  if (!fs.existsSync(configFilePath)) {
    fs.copyFileSync(
      "src/templates/openapi-v3-typescript-config.json.template",
      otherWayConfigFilePath
    );
  }
}
