import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// A generator responsible for creating repository implementation files.
///
/// The generated repository implementation:
/// - Implements the corresponding repository interface.
/// - Calls the remote API through the `Api` class.
/// - Wraps responses using `Either` for error handling.
/// - Uses `throwAppException` to safely catch and wrap exceptions.
class RepoImpGenerator {
  /// The map of API paths grouped by route and their corresponding methods.
  final List<RouteInfo> paths;

  /// The components defined in the Swagger file.
  final Components components;

  /// The list of modules to include in generation.
  final List<String> moduleList;

  /// The main base path where files will be generated.
  final String mainPath;

  /// Creates a [RepoImpGenerator] instance with the required inputs.
  RepoImpGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
    required this.mainPath,
  });

  /// Generates repository implementation files for all grouped API paths.
  ///
  /// Steps:
  /// 1. Group API paths by category.
  /// 2. Generate repository implementation for each category.
  void generateRepoImp() {
    try {
      Map<String, List<RouteInfo>> groupedPaths = {};

      // Group paths by category
      for (var path in paths) {
        String category = getCategory(path.fullRoute);
        if (!groupedPaths.containsKey(category)) {
          groupedPaths[category] = [];
        }
        groupedPaths[category]!.add(path);
      }

      // Generate repository implementation for each category
      for (var category in groupedPaths.keys) {
        _generateRepositoryForCategory(category, groupedPaths[category]!);
      }
    } catch (e) {
      printError('Error while generating repo imp: $e');
    }
  }

  /// Generates the repository implementation for a specific [category].
  ///
  /// - Implements the repository interface.
  /// - Registers methods corresponding to API endpoints.
  /// - Each method calls the remote API and wraps the response
  ///   in an `Either<String, Model>`.
  void _generateRepositoryForCategory(
    String category,
    List<RouteInfo> categoryPaths,
  ) {
    String filePath =
        '$mainPath/$category/infrastructure/repo_imp/${category}_repo_imp.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    // Imports
    buffer.writeln("import 'package:either_dart/either.dart';");
    buffer.writeln(
        "import '../../domain/repository/${category}_repository.dart';");
    buffer.writeln(
        "import '../../../../common/network/exception/error_handler.dart';");
    buffer.writeln("import '../datasource/remote/${category}_remote.dart';");

    // Add model imports for each route
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();

      buffer.writeln("import '../models/${actionName}_model.dart';");
    }

    // Add entity imports for each route
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();
      buffer
          .writeln("import '../../domain/entities/${actionName}_param.dart';");
    }

    buffer.writeln();

    // Class definition
    String className = category[0].toUpperCase() + category.substring(1);
    buffer.writeln(
        "class ${className}RepoImp implements ${className}Repository {");

    // Remote API reference
    buffer.writeln("  final ${className}Api _remote;");
    buffer.writeln(
        "  ${className}RepoImp({required ${className}Api api}) : _remote = api;");

    // Methods for each endpoint
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName;
      buffer.writeln();
      HttpMethodInfo info = path.httpMethodInfo;

      if (info.responses.response200 == null) continue;

      String methodName = actionName[0].toLowerCase() + actionName.substring(1);

      buffer.writeln("  @override");
      buffer.writeln("""
  /// Calls the remote [$actionName] API and returns an [Either].
  ///
  /// - On success: returns [${actionName}Model].
  /// - On failure: returns an error message.
  Future<Either<String, ${actionName}Model>> $methodName({
    required ${actionName}Param ${methodName}Param,
  }) {
    return throwAppException(() async {
      final response = await _remote.$methodName(
        ${methodName}Param: ${methodName}Param,
      );
      return response;
    });
  }""");
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
