import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/components.dart';
import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';
import 'package:flutter_easy_swagger_generator/helpers/converters.dart';
import '../../helpers/printer.dart';
import '../../helpers/utils.dart';

/// Generates repository abstract classes for each module/category
/// based on the Swagger paths.
class RepositoryGenerator {
  /// Map of API paths with their HTTP method info.
  final Map<String, Map<String, HttpMethodInfo>> paths;

  /// Swagger components for resolving references (not used directly here).
  final Components components;

  /// List of modules/categories to generate repositories for.
  final List<String> moduleList;

  /// Main path where generated files should be saved.
  final String mainPath;

  /// Constructor for [RepositoryGenerator].
  RepositoryGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
    required this.mainPath,
  });

  /// Generates repository files for all modules/categories.
  void generateRepository() {
    try {
      Map<String, List<MapEntry<String, Map<String, HttpMethodInfo>>>>
          groupedPaths = {};

      // Group API paths by category
      for (var path in paths.keys) {
        String category = getCategory(path);
        if (!groupedPaths.containsKey(category)) {
          groupedPaths[category] = [];
        }
        groupedPaths[category]!.add(MapEntry(path, paths[path]!));
      }

      // Generate repository for each category
      for (var category in groupedPaths.keys) {
        _generateRepositoryForCategory(category, groupedPaths[category]!);
      }
    } catch (e) {
      printError('Error while generating repositories: $e');
    }
  }

  /// Generates the repository abstract class for a specific category.
  ///
  /// Creates a file at:
  /// `lib/{category}/domain/repository/{category}_repository.dart`.
  /// Each API path with a 200 response will have a corresponding method:
  /// - Method returns `Future<Either<String, Model>>`
  /// - Takes a required `{Action}Param` parameter.
  void _generateRepositoryForCategory(
    String category,
    List<MapEntry<String, Map<String, HttpMethodInfo>>> categoryPaths,
  ) {
    String filePath =
        '$mainPath/$category/domain/repository/${category}_repository.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("import 'package:either_dart/either.dart';");

    // Import models for API responses
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);

      buffer.writeln(
          "import '../../infrastructure/models/${actionName}_model.dart';");
    }

    // Import entity classes for request parameters
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);
      buffer.writeln("import '../entities/${actionName}_param.dart';");
    }

    buffer.writeln();

    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);
    buffer.writeln("abstract class ${capitalizedCategory}Repository {");

    // Generate repository methods for each API endpoint
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;

      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        // Skip if the endpoint has no 200 response
        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);
        buffer.writeln(
          """
  /// Calls the API for $actionName.
  /// Returns either an error string or a ${actionName}Model.
  Future<Either<String, ${actionName}Model>> $methodName({
    required ${actionName}Param ${methodName}Param,
  });""",
        );
      }
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
