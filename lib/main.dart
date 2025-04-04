import 'dart:convert';
import 'dart:io';

// import 'package:flutter_easy_swagger_generator/generator/models_generator.dart';
import 'package:flutter_easy_swagger_generator/generator/routes_generator.dart';
import 'package:flutter_easy_swagger_generator/helpers/printer.dart';

import 'generator/architecture_generator.dart';
import 'helpers/get_modules_names.dart';
import 'type/http_method_info.dart';
import 'type/open_api_json.dart';

void main() {
//********************* Variables *******************************/
  String jsonString = File('lib/swagger.json').readAsStringSync();
  Map<String, dynamic> swaggerJson = jsonDecode(jsonString);
  IOpenApiJSON openApiJSON = IOpenApiJSON.fromJson(swaggerJson);
  Map<String, Map<String, HttpMethodInfo>> paths = openApiJSON.paths;
  List<ModuleInfo> moduleList = getModuleNames(paths);
//***************************************************************/

//********************* Generators Objects **********************/
  ArchitectureGenerator folderGenerator = ArchitectureGenerator();
  RoutesGenerator routesGenerator = RoutesGenerator(paths: paths);
//***************************************************************/

//********************* Generating **********************/
  routesGenerator.generateRoutes();
  folderGenerator.generateFolders(moduleList);
//*******************************************************/

  print('Folder generation complete.');
  printG("paths:\n$paths");

  paths.keys.forEach((path) {
    print(path);
  });
}
