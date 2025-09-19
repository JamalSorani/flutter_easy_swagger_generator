import '../../helpers/imports.dart';

class EntitiesGenerator {
  final List<RouteInfo> routesInfo;

  final Components components;

  final String mainPath;

  EntitiesGenerator({
    required this.routesInfo,
    required this.components,
    required this.mainPath,
  });

  /// Generates entity classes for all paths.
  ///
  /// Loops through each API path and uses [ClassGenerator] to create
  /// the corresponding Dart class for sending request data.
  void generateEntities() {
    final classGenerator = ClassGenerator(
      components: components,
      mainPath: mainPath,
    );
    for (var routeInfo in routesInfo) {
      classGenerator.generateClass(routeInfo);
    }
  }
}
