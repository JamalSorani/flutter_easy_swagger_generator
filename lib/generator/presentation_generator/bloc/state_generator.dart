import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates the `State` class for each module/category based on the Swagger paths.
/// Each state class contains `Result<T>` fields for each API action,
/// along with constructor and `copyWith` method for immutable updates.
class StateGenerator {
  final Map<String, List<RouteInfo>> groupedRoutes;
  final String mainPath;

  StateGenerator({
    required this.groupedRoutes,
    required this.mainPath,
  });

  /// Generates a single state file for a given category
  void generateStateForCategory(
    String category,
  ) {
    String filePath = FilePath(
      mainPath: mainPath,
      category: category,
      isMVVM: false,
    ).stateFilePath;
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
    for (var path in groupedRoutes[category]!) {
      String routeName =
          getRouteName(path.fullRoute); // Convert path to action name
      String actionName = routeName;

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
      String methodName =
          "${actionName[0].toLowerCase()}${actionName.substring(1)}State";
      buffer.writeln("      $methodName: $methodName ?? this.$methodName,");
    }

    buffer.writeln("    );");
    buffer.writeln("  }");
  }
}
