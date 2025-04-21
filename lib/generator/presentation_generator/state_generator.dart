import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/components.dart';
import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';
import '../../helpers/printer.dart';
import '../../helpers/utils.dart';

class StateGenerator {
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;
  final List<String> moduleList;
  final String mainPath;

  StateGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
    required this.mainPath,
  });

  void generateState() {
    try {
      Map<String, List<MapEntry<String, Map<String, HttpMethodInfo>>>>
          groupedPaths = {};

      for (var path in paths.keys) {
        String category = getCategory(path);
        if (!groupedPaths.containsKey(category)) {
          groupedPaths[category] = [];
        }
        groupedPaths[category]!.add(MapEntry(path, paths[path]!));
      }

      for (var category in groupedPaths.keys) {
        _generateState(category, groupedPaths[category]!);
      }
    } catch (e) {
      printError('Error while generating repositories: $e');
    }
  }

  void _generateState(
    String category,
    List<MapEntry<String, Map<String, HttpMethodInfo>>> categoryPaths,
  ) {
    String filePath =
        '$mainPath/$category/presentation/state/${category}_state.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("part of '${category}_bloc.dart';");
    String capitalizedCategory =
        (category[0].toUpperCase() + category.substring(1));
    buffer.writeln();
    buffer.writeln("class ${capitalizedCategory}State {");
    List<String> actions = [];
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;

      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);
        actions.add(actionName);
        buffer.writeln(
          "  Result<${actionName}Model> ${methodName}State;",
        );
      }
    }
    buffer.writeln();
    _generateConstructor(buffer, capitalizedCategory, actions);
    buffer.writeln();
    _generateCopyWith(buffer, capitalizedCategory, actions);
    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }

  _generateConstructor(
      StringBuffer buffer, String capitalizedCategory, List<String> actions) {
    buffer.writeln("  ${capitalizedCategory}State({");
    for (int index = 0; index < actions.length; index++) {
      String actionName = actions[index];
      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      buffer.writeln(
        "    this.${methodName}State = const Result.init(),",
      );
    }

    buffer.writeln("  });");
  }

  _generateCopyWith(
      StringBuffer buffer, String capitalizedCategory, List<String> actions) {
    buffer.writeln("  ${capitalizedCategory}State copyWith({");
    for (int index = 0; index < actions.length; index++) {
      String actionName = actions[index];
      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      buffer.writeln(
        "    Result<${actionName}Model>? ${methodName}State,",
      );
    }
    buffer.writeln("""
  }) {
    return ${capitalizedCategory}State(""");
    for (int index = 0; index < actions.length; index++) {
      String actionName = actions[index];
      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      String state = "${methodName}State";
      buffer.writeln(
        "      $state: $state ?? this.$state,",
      );
    }

    buffer.writeln("""
    );
  }""");
  }
}
