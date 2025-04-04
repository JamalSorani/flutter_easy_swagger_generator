import 'dart:convert';
import 'dart:io';
import 'package:flutter_easy_swagger_generator/generator/routes_generator.dart';
import 'generator/architecture_generator.dart';
import 'generator/entities_generator.dart';
import 'helpers/utils.dart';
import 'classes/http_method_info.dart';
import 'classes/open_api_json.dart';

void main() {
//********************* Variables *******************************/
  String jsonString = File('lib/swagger.json').readAsStringSync();
  Map<String, dynamic> swaggerJson = jsonDecode(jsonString);
  IOpenApiJSON openApiJSON = IOpenApiJSON.fromJson(swaggerJson);
  Map<String, Map<String, HttpMethodInfo>> paths = openApiJSON.paths;
  List<String> moduleList = getModuleNames(paths);
//***************************************************************/

//********************* Generators Objects **********************/
  ArchitectureGenerator folderGenerator = ArchitectureGenerator();
  RoutesGenerator routesGenerator = RoutesGenerator(paths: paths);
  EntitiesGenerator entitiesGenerator = EntitiesGenerator(
    moduleList: moduleList,
    paths: paths,
  );
//***************************************************************/

//********************* Generating **********************/
  routesGenerator.generateRoutes();
  folderGenerator.generateFolders(moduleList);
  entitiesGenerator.generateEntities();
//*******************************************************/
}
