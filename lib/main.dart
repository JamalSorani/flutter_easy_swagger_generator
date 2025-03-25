import 'dart:convert';
import 'dart:developer';
import 'dart:io';

// import 'package:flutter_easy_swagger_generator/generator/models_generator.dart';
import 'package:flutter_easy_swagger_generator/generator/routes_generator.dart';

import 'generator/architecture_generator.dart';
import 'type/http_method_info.dart';
import 'type/open_api_json.dart';

void main() {
  String jsonString = File('lib/swagger.json').readAsStringSync();
  Map<String, dynamic> swaggerJson = jsonDecode(jsonString);
  IOpenApiJSON openApiJSON = IOpenApiJSON.fromJson(swaggerJson);
  Map<String, Map<String, HttpMethodInfo>> paths = openApiJSON.paths;

  ArchitectureGenerator folderGenerator = ArchitectureGenerator(paths: paths);
  RoutesGenerator routesGenerator = RoutesGenerator(paths: paths);
  // ModelsGenerator modelsGenerator =
  //     ModelsGenerator(paths: paths, components: openApiJSON.components);

  routesGenerator.generateRoutes();
  List<ModuleInfo> moduleList = folderGenerator.getModuleNames();
  folderGenerator.generateFolders(moduleList);
  // modelsGenerator.generateModels();

  log('Folder generation complete.');
}
