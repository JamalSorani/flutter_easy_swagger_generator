import '../../helpers/imports.dart';

class EntitiesGenerator {
  final List<RouteInfo> routesInfo;

  final Components components;

  final String mainPath;

  final String globalEnumsFileString;

  EntitiesGenerator({
    required this.routesInfo,
    required this.components,
    required this.globalEnumsFileString,
    required this.mainPath,
  });

  /// Generates entity classes for all paths.
  ///
  /// Loops through each API path and uses [EntityClassGenerator] to create
  /// the corresponding Dart class for sending request data.
  void generateEntities() {
    final classGenerator = EntityClassGenerator(
      components: components,
      mainPath: mainPath,
      globalEnumsFileString: globalEnumsFileString,
    );
    for (var routeInfo in routesInfo) {
      classGenerator.generateClass(routeInfo);
    }
  }
}
