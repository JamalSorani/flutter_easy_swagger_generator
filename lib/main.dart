import 'dart:convert';
import 'dart:io';
import 'package:flutter_easy_swagger_generator/generator/network_generator/routes_generator.dart';
import 'package:flutter_easy_swagger_generator/helpers/printer.dart';
import 'classes/components.dart';
import 'generator/application_generator/application_generator.dart';
import 'generator/infrastructure_generator/remote_generator.dart';
import 'generator/domain_generator/entities_generator.dart';
import 'generator/domain_generator/repository_generator.dart';
import 'generator/infrastructure_generator/models_generator.dart';
import 'generator/infrastructure_generator/repo_imp_generator.dart';
import 'generator/network_generator/network_generator.dart';
import 'classes/http_method_info.dart';
import 'classes/open_api_json.dart';
import 'helpers/formatter.dart';
import 'helpers/get_modules_names.dart';

void main(List<String> arguments) {
  // Get swagger file path from arguments or use default
  String swaggerPath = 'lib/swagger.json';
  if (arguments.isNotEmpty) {
    swaggerPath = arguments[0];
  }

  // Check if swagger file exists
  if (!File(swaggerPath).existsSync()) {
    printError('Error: Swagger file not found at $swaggerPath');
    printInfo('Usage: dart run main.dart [path_to_swagger.json]');
    exit(1);
  }

//********************* Variables *******************************/
  String jsonString = File(swaggerPath).readAsStringSync();
  Map<String, dynamic> swaggerJson = jsonDecode(jsonString);
  IOpenApiJSON openApiJSON = IOpenApiJSON.fromJson(swaggerJson);
  Components components = openApiJSON.components;
  Map<String, Map<String, HttpMethodInfo>> paths = openApiJSON.paths;
  List<String> moduleList = getModuleNames(paths);
//***************************************************************/

//********************* Generators Objects **********************/
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
  NetworkGenerator networkGenerator = NetworkGenerator();
  RemoteGenerator remoteGenerator = RemoteGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
  );
  RepoImpGenerator repoImpGenerator = RepoImpGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
  );
  ApplicationGenerator applicationGenerator = ApplicationGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
  );
//***************************************************************/

//********************* Generating **********************/
  printInfo('\nGenerating code from swagger file: $swaggerPath');
  routesGenerator.generateRoutes();
  entitiesGenerator.generateEntities();
  responseModelsGenerator.generateModels();
  repositoryGenerator.generateRepository();
  networkGenerator.generateNetwork();
  remoteGenerator.generateRemote();
  repoImpGenerator.generateRepository();
  applicationGenerator.generateApplication();
  printSuccess('Code generation completed!\n');
//*******************************************************/

//********************* Formatting **********************/
  if (promptUser('Do you want to format the generated files?') == 'y') {
    printInfo('\nFormatting generated files...');
    formatDirectory('lib/app');
  }
//*******************************************************/
}
