import 'dart:convert';
import 'dart:io';

import '../classes/components.dart';
import '../classes/http_method_info.dart';
import '../classes/open_api_json.dart';
import '../helpers/get_modules_names.dart';
import '../helpers/printer.dart';
import 'application_generator/application_generator.dart';
import 'domain_generator/entities_generator.dart';
import 'domain_generator/repository_generator.dart';
import 'infrastructure_generator/models_generator.dart';
import 'infrastructure_generator/remote_generator.dart';
import 'infrastructure_generator/repo_imp_generator.dart';
import 'network_generator/network_generator.dart';
import 'network_generator/routes_generator.dart';

/// Main function to generate code from a swagger file
Future<void> swaggerGenerator(String swaggerPath) async {
  // Check if swagger file exists
  if (!File(swaggerPath).existsSync()) {
    printError('Error: Swagger file not found at $swaggerPath');
    printInfo('Usage: dart run main.dart [path_to_swagger.json]');
    return;
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
  await Future.wait([
    Future(() => routesGenerator.generateRoutes()),
    Future(() => entitiesGenerator.generateEntities()),
    Future(() => responseModelsGenerator.generateModels()),
    Future(() => repositoryGenerator.generateRepository()),
    Future(() => networkGenerator.generateNetwork()),
    Future(() => remoteGenerator.generateRemote()),
    Future(() => repoImpGenerator.generateRepoImp()),
    Future(() => applicationGenerator.generateApplication()),
  ]);
  printSuccess('Code generation completed!\n');
  //*******************************************************/

  //********************* Formatting **********************/
  // if (promptUser('Do you want to format the generated files?') == 'y') {
  //   printInfo('\nFormatting generated files...');
  //   await formatDirectory('lib/app');
  // }
  //*******************************************************/
}
