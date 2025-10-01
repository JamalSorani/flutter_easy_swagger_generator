import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates the application layer (facade classes) for each API category.
///
/// This generator is responsible for:
/// - Grouping Swagger paths by category (provided via [groupedRoutes]).
/// - Generating a facade class per category that exposes repository methods.
/// - Importing models and entities for each API route.
class ApplicationGenerator {
  /// Grouped routes keyed by category name.
  final Map<String, List<RouteInfo>> groupedRoutes;

  /// Root output directory where generated files will be written.
  final String mainPath;

  /// Creates an [ApplicationGenerator] with the necessary inputs.
  ApplicationGenerator({
    required this.groupedRoutes,
    required this.mainPath,
  });

  /// Generates a facade class for a single [category].
  ///
  /// The facade wires domain repository methods and exposes typed methods that
  /// return `Either<String, Model>` for error handling.
  void generateApplicationForCategory(
    String category,
  ) {
    List<RouteInfo> categoryPaths = groupedRoutes[category]!;
    String filePath = FilePath(
      mainPath: mainPath,
      category: category,
      isMVVM: false,
    ).applicationFilePath;
    final file = File(filePath);
    file.parent.createSync(recursive: true);

    final buffer = StringBuffer();

    buffer.writeln("import 'package:either_dart/either.dart';");
    buffer
        .writeln("import '../domain/repository/${category}_repository.dart';");

    for (var pathEntry in categoryPaths) {
      String routeName = getRouteName(pathEntry.fullRoute);
      String actionName = routeName.toSnakeCase();
      buffer.writeln(
          "import '../infrastructure/models/${actionName}_model.dart';");
    }

    for (var pathEntry in categoryPaths) {
      String routeName = getRouteName(pathEntry.fullRoute);
      String actionName = routeName.toSnakeCase();
      buffer.writeln("import '../domain/entities/${actionName}_param.dart';");
    }

    buffer.writeln();

    String className = category[0].toUpperCase() + category.substring(1);

    buffer.writeln("class ${className}Facade {");
    buffer.writeln("  final ${className}Repository _repository;");

    buffer.writeln("""
  ${className}Facade({required ${className}Repository repository})
      : _repository = repository;
""");

    for (var pathEntry in categoryPaths) {
      String routeName = getRouteName(pathEntry.fullRoute);
      String actionName = routeName;

      String methodName = actionName[0].toLowerCase() + actionName.substring(1);

      buffer.writeln("""
  Future<Either<String, ${actionName}Model>> $methodName({
    required ${actionName}Param ${methodName}Param,
  }) =>
      _repository.$methodName(${methodName}Param: ${methodName}Param);
""");
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
