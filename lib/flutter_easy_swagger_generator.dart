import 'package:flutter_easy_swagger_generator/generator/enums_generator.dart';
import 'package:flutter_easy_swagger_generator/helpers/imports.dart';
import 'dart:io';

Future<void> swaggerGenerator(String swaggerPath,
    {List<String>? prefixesToRemove}) async {
  String mainPath = "lib/app";

  // Check if swagger file exists
  if (!File(swaggerPath).existsSync()) {
    printError('Error: Swagger file not found at $swaggerPath');
    printInfo('Usage: dart run main.dart [path_to_swagger.json]');
    return;
  }
  if (prefixesToRemove != null) {
    ConstantsHelper.allPrefixesToRemove.addAll(prefixesToRemove);
  }

  //********************* Variables *******************************/
  String jsonString = File(swaggerPath).readAsStringSync();
  Map<String, dynamic> swaggerJson = jsonDecode(jsonString);
  OpenApiJSON openApiJSON = OpenApiJSON.fromJson(swaggerJson);
  Components components = openApiJSON.components;
  List<RouteInfo> routesInfo = openApiJSON.paths;
  Map<String, List<RouteInfo>> groupedRoutes = {};
  for (var routeInfo in routesInfo) {
    String category = getCategory(routeInfo.fullRoute);
    groupedRoutes.putIfAbsent(category, () => []).add(routeInfo);
  }
  //***************************************************************/

  //********************* Generators Objects **********************/
  RoutesGenerator routesGenerator = RoutesGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
  );
  EnumsGenerator enumsGenerator = EnumsGenerator(
    components: components,
    mainPath: mainPath,
  );
  String globalEnumsFileString = enumsGenerator.generateEnums();
  EntitiesGenerator entitiesGenerator = EntitiesGenerator(
    routesInfo: routesInfo,
    components: components,
    mainPath: mainPath,
    globalEnumsFileString: globalEnumsFileString,
  );
  ModelsGenerator responseModelsGenerator = ModelsGenerator(
    routesInfo: routesInfo,
    components: components,
    mainPath: mainPath,
    globalEnumsFileString: globalEnumsFileString,
  );

  RepositoryGenerator repositoryGenerator = RepositoryGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
  );
  RemoteGenerator remoteGenerator = RemoteGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
  );
  RepoImpGenerator repoImpGenerator = RepoImpGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
  );
  ApplicationGenerator applicationGenerator = ApplicationGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
  );
  BlocGenerator blocGenerator = BlocGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
  );
  EventGenerator eventGenerator = EventGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
  );
  StateGenerator stateGenerator = StateGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
  );

  for (var category in groupedRoutes.keys) {
    repositoryGenerator.generateRepositoryForCategory(category);
    remoteGenerator.generateRemoteForCategory(category);
    repoImpGenerator.generateRepositoryForCategory(category);
    applicationGenerator.generateApplicationForCategory(category);
    blocGenerator.generateBlocForCategory(category);
    eventGenerator.generateEventForCategory(category);
    stateGenerator.generateStateForCategory(category);
  }

  NetworkGenerator networkGenerator = NetworkGenerator(
    mainPath: mainPath,
  );

  ResultBuilderGenerator resultBuilderGenerator = ResultBuilderGenerator(
    mainPath: mainPath,
  );
  List<String> moduleList = getModuleNames(routesInfo);
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
    Future(() => networkGenerator.generateNetwork()),
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

