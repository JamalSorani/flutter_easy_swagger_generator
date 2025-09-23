import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class RepositoryGenerator {
  final Map<String, List<RouteInfo>> groupedRoutes;

  /// Main path where generated files should be saved.
  final String mainPath;

  /// Constructor for [RepositoryGenerator].
  RepositoryGenerator({
    required this.groupedRoutes,
    required this.mainPath,
  });

  /// Generates the repository abstract class for a specific category.
  ///
  /// Creates a file at:
  /// `lib/{category}/domain/repository/{category}_repository.dart`.
  /// Each API path with a 200 response will have a corresponding method:
  /// - Method returns `Future<Either<String, Model>>`
  /// - Takes a required `{Action}Param` parameter.
  void generateRepositoryForCategory(
    String category,
  ) {
    List<RouteInfo> categoryPaths = groupedRoutes[category]!;
    String filePath =
        '$mainPath/$category/domain/repository/${category}_repository.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("import 'package:either_dart/either.dart';");

    // Import models for API responses
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();

      buffer.writeln(
          "import '../../infrastructure/models/${actionName}_model.dart';");
    }

    // Import entity classes for request parameters
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();
      buffer.writeln("import '../entities/${actionName}_param.dart';");
    }

    buffer.writeln();

    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);
    buffer.writeln("abstract class ${capitalizedCategory}Repository {");

    // Generate repository methods for each API endpoint
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName;

      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      buffer.writeln(
        """
  Future<Either<String, ${actionName}Model>> $methodName({
    required ${actionName}Param ${methodName}Param,
  });""",
      );
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
