import 'dart:convert';
import 'dart:io';

import 'package:flutter_easy_swagger_generator/generator/presentation_generator/bloc_generator.dart';
import 'package:flutter_easy_swagger_generator/generator/presentation_generator/event_generator.dart';
import 'package:flutter_easy_swagger_generator/generator/presentation_generator/state_generator.dart';
import 'package:flutter_easy_swagger_generator/generator/result_builder_generator/result_builder_generator.dart';

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
import 'injection_generator/injection_generator.dart';
import 'network_generator/network_generator.dart';
import 'network_generator/routes_generator.dart';

/// Generates clean architecture code from a Swagger/OpenAPI specification.
///
/// This function is the main entry point for code generation. It takes a path to a Swagger file
/// or a URL to a Swagger specification and generates the following components:
///
/// * Routes - API route definitions and handlers
/// * Entities - Domain entities representing your data models
/// * Models - Data transfer objects and response models
/// * Repositories - Abstract repository interfaces
/// * Network - Network client and configuration
/// * Remote - Remote data source implementations
/// * Repository Implementations - Concrete repository implementations
/// * Application - Use cases and application logic
///
/// The generated code follows clean architecture principles with clear separation of concerns.
///
/// Example:
/// ```dart
/// // Generate from local file
/// await swaggerGenerator('path/to/swagger.json');
///
/// // Generate from remote URL
/// await swaggerGenerator('https://api.example.com/swagger.json');
///
/// // Generate example code
/// await swaggerGenerator('path/to/swagger.json', isExample: true);
/// ```
///
/// Parameters:
/// * [swaggerPath] - Path to the Swagger file or URL to the Swagger specification
/// * [isExample] - Whether to generate example code (defaults to false)
Future<void> swaggerGenerator(String swaggerPath,
    {bool isExample = false}) async {
  String mainPath = "${isExample ? 'example/' : ''}lib/app";

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
  RoutesGenerator routesGenerator = RoutesGenerator(
    paths: paths,
    mainPath: mainPath,
  );
  EntitiesGenerator entitiesGenerator = EntitiesGenerator(
    moduleList: moduleList,
    paths: paths,
    components: components,
    mainPath: mainPath,
  );
  ModelsGenerator responseModelsGenerator = ModelsGenerator(
    moduleList: moduleList,
    paths: paths,
    components: components,
    mainPath: mainPath,
  );
  RepositoryGenerator repositoryGenerator = RepositoryGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
    mainPath: mainPath,
  );
  NetworkGenerator networkGenerator = NetworkGenerator(
    mainPath: mainPath,
  );
  RemoteGenerator remoteGenerator = RemoteGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
    mainPath: mainPath,
  );
  RepoImpGenerator repoImpGenerator = RepoImpGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
    mainPath: mainPath,
  );
  ApplicationGenerator applicationGenerator = ApplicationGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
    mainPath: mainPath,
  );
  BlocGenerator blocGenerator = BlocGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
    mainPath: mainPath,
  );
  EventGenerator eventGenerator = EventGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
    mainPath: mainPath,
  );
  StateGenerator stateGenerator = StateGenerator(
    paths: paths,
    components: components,
    moduleList: moduleList,
    mainPath: mainPath,
  );
  ResultBuilderGenerator resultBuilderGenerator = ResultBuilderGenerator(
    mainPath: mainPath,
  );
  InjectionGenerator injectionGenerator = InjectionGenerator(
    mainPath: mainPath,
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
    Future(() => blocGenerator.generateBloc()),
    Future(() => eventGenerator.generateEvent()),
    Future(() => stateGenerator.generateState()),
    Future(() => resultBuilderGenerator.generateResultBuilder()),
    Future(() => injectionGenerator.generateInjection()),
  ]);
  printSuccess('Code generation completed!\n');
  //*******************************************************/

  //********************* Formatting **********************/
  // if (promptUser('Do you want to format the generated files?') == 'y') {
  //   printInfo('\nFormatting generated files...');
  //   await formatDirectory('$mainPath');
  // }
  //*******************************************************/
}
