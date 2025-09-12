import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/components.dart';
import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';
import '../../helpers/printer.dart';
import '../../helpers/utils.dart';

/// Generates event classes for each module/category based on Swagger paths.
/// Each event corresponds to an API action and contains the parameters (`Param`) required for that action.
class EventGenerator {
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;
  final List<String> moduleList;
  final String mainPath;

  EventGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
    required this.mainPath,
  });

  /// Entry point to generate all events.
  void generateEvent() {
    try {
      // Group paths by category
      Map<String, List<MapEntry<String, Map<String, HttpMethodInfo>>>>
          groupedPaths = {};

      for (var path in paths.keys) {
        String category = getCategory(path);
        groupedPaths.putIfAbsent(category, () => []);
        groupedPaths[category]!.add(MapEntry(path, paths[path]!));
      }

      // Generate events for each category
      for (var category in groupedPaths.keys) {
        _generateEventForCategory(category, groupedPaths[category]!);
      }
    } catch (e) {
      printError('Error while generating events: $e');
    }
  }

  /// Generates the event file for a specific category
  void _generateEventForCategory(
    String category,
    List<MapEntry<String, Map<String, HttpMethodInfo>>> categoryPaths,
  ) {
    String filePath =
        '$mainPath/$category/presentation/state/${category}_event.dart';
    final file = File(filePath);
    file.parent.createSync(recursive: true); // Ensure folder exists
    final buffer = StringBuffer();

    // Part directive to connect with the BLoC file
    buffer.writeln("part of '${category}_bloc.dart';");

    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);

    buffer.writeln("""
abstract class ${capitalizedCategory}Event {}
""");

    // Generate event class for each API action with response 200
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;

      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);

        buffer.writeln("""
class ${actionName}Event extends ${capitalizedCategory}Event {
  final ${actionName}Param ${methodName}Param;

  ${actionName}Event({required this.${methodName}Param});
}
""");
      }
    }

    // Write the generated file
    file.writeAsStringSync(buffer.toString());
  }
}
