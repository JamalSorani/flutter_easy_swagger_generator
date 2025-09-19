import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates the `State` class for each module/category based on the Swagger paths.
/// Each state class contains `Result<T>` fields for each API action,
/// along with constructor and `copyWith` method for immutable updates.
class StateGenerator {
  final List<RouteInfo> paths;
  final Components components;
  final List<String> moduleList;
  final String mainPath;

  StateGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
    required this.mainPath,
  });

  /// Entry point to generate all state classes.
  void generateState() {
    try {
      // Group paths by category
      Map<String, List<RouteInfo>> groupedPaths = {};

      for (var path in paths) {
        String category = getCategory(path.fullRoute); // Get category from path
        groupedPaths.putIfAbsent(category, () => []);
        groupedPaths[category]!.add(path);
      }

      // Generate state for each category
      for (var category in groupedPaths.keys) {
        _generateState(category, groupedPaths[category]!);
      }
    } catch (e) {
      printError('Error while generating state classes: $e');
    }
  }

  /// Generates a single state file for a given category
  void _generateState(
    String category,
    List<RouteInfo> categoryPaths,
  ) {
    String filePath =
        '$mainPath/$category/presentation/state/${category}_state.dart';
    final file = File(filePath);
    file.parent.createSync(recursive: true); // Ensure folder exists
    final buffer = StringBuffer();

    // Part directive to connect with the BLoC file
    buffer.writeln("part of '${category}_bloc.dart';");

    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);

    buffer.writeln();
    buffer.writeln("class ${capitalizedCategory}State {");

    List<String> actions = [];

    // Generate Result<T> fields for each route
    for (var path in categoryPaths) {
      String routeName =
          getRouteName(path.fullRoute); // Convert path to action name
      String actionName = routeName;

      HttpMethodInfo info = path.httpMethodInfo;

      // Only generate fields for routes with 200 response
      if (info.responses.response200 == null) continue;

      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      actions.add(actionName);
      buffer.writeln("  Result<${actionName}Model> ${methodName}State;");
    }

    buffer.writeln();

    // Constructor with default init states
    _generateConstructor(buffer, capitalizedCategory, actions);
    buffer.writeln();

    // copyWith method for immutable state updates
    _generateCopyWith(buffer, capitalizedCategory, actions);

    buffer.writeln("}");

    // Write file
    file.writeAsStringSync(buffer.toString());
  }

  /// Generates the constructor for the state class
  void _generateConstructor(
      StringBuffer buffer, String capitalizedCategory, List<String> actions) {
    buffer.writeln("  ${capitalizedCategory}State({");
    for (var actionName in actions) {
      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      buffer.writeln("    this.${methodName}State = const Result.init(),");
    }
    buffer.writeln("  });");
  }

  /// Generates a copyWith method for the state class
  void _generateCopyWith(
      StringBuffer buffer, String capitalizedCategory, List<String> actions) {
    buffer.writeln("  ${capitalizedCategory}State copyWith({");
    for (var actionName in actions) {
      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      buffer.writeln("    Result<${actionName}Model>? ${methodName}State,");
    }

    buffer.writeln("  }) {");
    buffer.writeln("    return ${capitalizedCategory}State(");

    for (var actionName in actions) {
      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      buffer.writeln("      $methodName: $methodName ?? this.$methodName,");
    }

    buffer.writeln("    );");
    buffer.writeln("  }");
  }
}
