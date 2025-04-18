import 'dart:convert';
import 'dart:io';
import 'package:flutter_easy_swagger_generator/generator/routes_generator.dart';
import 'classes/components.dart';
import 'generator/architecture_generator.dart';
import 'generator/domain_generator/entities_generator.dart';
import 'generator/domain_generator/repository_generator.dart';
import 'generator/infrastructure_generator/models_generator.dart';
import 'helpers/utils.dart';
import 'classes/http_method_info.dart';
import 'classes/open_api_json.dart';

void main() {
//********************* Variables *******************************/
  String jsonString = File('lib/swagger.json').readAsStringSync();
  Map<String, dynamic> swaggerJson = jsonDecode(jsonString);
  IOpenApiJSON openApiJSON = IOpenApiJSON.fromJson(swaggerJson);
  Components components = openApiJSON.components;
  Map<String, Map<String, HttpMethodInfo>> paths = openApiJSON.paths;
  List<String> moduleList = getModuleNames(paths);
//***************************************************************/

//********************* Generators Objects **********************/
  ArchitectureGenerator folderGenerator = ArchitectureGenerator();
  RoutesGenerator routesGenerator = RoutesGenerator(paths: paths);
  EntitiesGenerator entitiesGenerator = EntitiesGenerator(
    moduleList: moduleList,
    paths: paths,
    components: components,
  );
  ModelsGenerator responseModelsGenerator = ModelsGenerator(
    moduleList: moduleList,
    paths: paths,
    components: components,
  );
  RepositoryGenerator repositoryGenerator = RepositoryGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
  );
//***************************************************************/

//********************* Generating **********************/
  routesGenerator.generateRoutes();
  folderGenerator.generateFolders(moduleList);
  entitiesGenerator.generateEntities();
  responseModelsGenerator.generateModels();
  repositoryGenerator.generateRepository();
//*******************************************************/
}
