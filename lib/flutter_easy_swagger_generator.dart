import 'dart:io';
import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Enum for choosing state management type
enum StateManagementType { bloc, provider, riverpod, all }

/// Enum for choosing architecture type
enum ArchitectureType { clean, mvvm }

Future<void> swaggerGenerator(
  String swaggerPath, {
  List<String>? prefixesToRemove,
}) async {
  String mainPath = "lib/app";

  //********************* Check swagger file *******************************/
  if (!File(swaggerPath).existsSync()) {
    printError('Error: Swagger file not found at $swaggerPath');
    printInfo('Usage: dart run main.dart [path_to_swagger.json]');
    return;
  }

  if (prefixesToRemove != null) {
    ConstantsHelper.allPrefixesToRemove.addAll(prefixesToRemove);
  }

  //********************* Load swagger *******************************/
  String jsonString = File(swaggerPath).readAsStringSync();
  Map<String, dynamic> swaggerJson = jsonDecode(jsonString);
  OpenApiJSON openApiJSON = OpenApiJSON.fromJson(swaggerJson);
  Components components = openApiJSON.components;
  List<RouteInfo> routesInfo = openApiJSON.paths;

  //********************* Ask user for architecture type *******************************/
  printInfo('\nChoose your architecture type:');
  printInfo('1️⃣  Clean Architecture');
  printInfo('2️⃣  MVVM');
  stdout.write('Enter choice (1 or 2): ');
  String? archChoice = stdin.readLineSync();

  ArchitectureType architectureType = (archChoice?.trim() == '2')
      ? ArchitectureType.mvvm
      : ArchitectureType.clean;

  final bool isMVVM = architectureType == ArchitectureType.mvvm;
  printInfo('Selected architecture: ${isMVVM ? "MVVM" : "Clean Architecture"}');

  //********************* Group routes by category *******************************/
  Map<String, List<RouteInfo>> groupedRoutes = {};
  for (var routeInfo in routesInfo) {
    String category = getCategory(routeInfo.fullRoute);
    groupedRoutes.putIfAbsent(category, () => []).add(routeInfo);
  }

  //********************* Ask user for state management *******************************/
  final Set<StateManagementType> selectedTypes = {};
  if (isMVVM) {
    selectedTypes.add(StateManagementType.provider);
  } else {
    printInfo(
        '\nChoose your state management type (comma-separated for multiple):');
    printInfo('1️⃣  BLoC');
    printInfo('2️⃣  Provider');
    printInfo('3️⃣  Riverpod');
    stdout.write('Enter choices (e.g., 1,3 for BLoC + Riverpod): ');
    String? choice = stdin.readLineSync();

    if (choice != null) {
      for (var c in choice.split(',')) {
        switch (c.trim()) {
          case '1':
            selectedTypes.add(StateManagementType.bloc);
            break;
          case '2':
            selectedTypes.add(StateManagementType.provider);
            break;
          case '3':
            selectedTypes.add(StateManagementType.riverpod);
            break;
        }
      }
    }
    if (selectedTypes.isEmpty) selectedTypes.add(StateManagementType.bloc);
    printInfo(
        'Selected state management: ${selectedTypes.map((e) => e.name).join(', ')}');
  }

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
    isMVVM: isMVVM,
  );

  ModelsGenerator responseModelsGenerator = ModelsGenerator(
    routesInfo: routesInfo,
    components: components,
    mainPath: mainPath,
    globalEnumsFileString: globalEnumsFileString,
    isMVVM: isMVVM,
  );

  RepositoryGenerator repositoryGenerator = RepositoryGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
    isMVVM: isMVVM,
  );

  RemoteGenerator remoteGenerator = RemoteGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
    isMVVM: isMVVM,
  );

  // Clean Architecture specific
  RepoImpGenerator repoImpGenerator = RepoImpGenerator(
    groupedRoutes: groupedRoutes,
    mainPath: mainPath,
    isMVVM: isMVVM,
  );

  // ApplicationGenerator applicationGenerator = ApplicationGenerator(
  //   groupedRoutes: groupedRoutes,
  //   mainPath: mainPath,
  // );

  //********************* State management generators **********************/
  BlocGenerator? blocGenerator;
  EventGenerator? eventGenerator;
  StateGenerator? stateGenerator;
  ProviderGenerator? providerGenerator;
  RiverpodGenerator? riverpodGenerator;

  if (selectedTypes.contains(StateManagementType.bloc)) {
    blocGenerator =
        BlocGenerator(groupedRoutes: groupedRoutes, mainPath: mainPath);
    eventGenerator =
        EventGenerator(groupedRoutes: groupedRoutes, mainPath: mainPath);
    stateGenerator =
        StateGenerator(groupedRoutes: groupedRoutes, mainPath: mainPath);
  }

  if (selectedTypes.contains(StateManagementType.provider)) {
    providerGenerator = ProviderGenerator(
      groupedRoutes: groupedRoutes,
      mainPath: mainPath,
      isMVVM: isMVVM,
    );
  }

  if (selectedTypes.contains(StateManagementType.riverpod)) {
    riverpodGenerator =
        RiverpodGenerator(groupedRoutes: groupedRoutes, mainPath: mainPath);
  }

  //********************* Generate per category **********************/
  for (var category in groupedRoutes.keys) {
    repositoryGenerator.generateRepositoryForCategory(category);
    remoteGenerator.generateRemoteForCategory(category);
    repoImpGenerator.generateRepositoryForCategory(category);

    if (!isMVVM) {
      // applicationGenerator.generateApplicationForCategory(category);
    }

    if (selectedTypes.contains(StateManagementType.bloc)) {
      blocGenerator?.generateBlocForCategory(category);
      eventGenerator?.generateEventForCategory(category);
      stateGenerator?.generateStateForCategory(category);
    }

    if (selectedTypes.contains(StateManagementType.provider)) {
      providerGenerator?.generateProviderForCategory(category);
    }

    if (selectedTypes.contains(StateManagementType.riverpod)) {
      riverpodGenerator?.generateRiverpodForCategory(category);
    }
  }

  //********************* Shared generators **********************/
  NetworkGenerator networkGenerator = NetworkGenerator(mainPath: mainPath);
  ResultBuilderGenerator resultBuilderGenerator =
      ResultBuilderGenerator(mainPath: mainPath);
  List<String> moduleList = getModuleNames(routesInfo);

  InjectionGenerator injectionGenerator = InjectionGenerator(
    mainPath: mainPath,
    moduleList: moduleList,
    stateManagementType: selectedTypes.length == 1
        ? selectedTypes.first
        : StateManagementType.all,
    isMVVM: isMVVM,
  );

  //********************* Generate shared code **********************/
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
}
