import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates event classes for each module/category based on Swagger paths.
/// Each event corresponds to an API action and contains the parameters (`Param`) required for that action.
class EventGenerator {
  final Map<String, List<RouteInfo>> groupedRoutes;
  final String mainPath;

  EventGenerator({
    required this.groupedRoutes,
    required this.mainPath,
  });

  /// Generates the event file for a specific category
  void generateEventForCategory(
    String category,
  ) {
    List<RouteInfo> categoryPaths = groupedRoutes[category]!;
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
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName;
      String actionEventName = actionName;
      if (actionEventName == capitalizedCategory) {
        actionEventName = "${actionName}Event";
      }

      String methodName = actionName[0].toLowerCase() + actionName.substring(1);

      buffer.writeln("""
class ${actionEventName}Event extends ${capitalizedCategory}Event {
  final ${actionName}Param ${methodName}Param;

  ${actionEventName}Event({required this.${methodName}Param});
}
""");
    }

    // Write the generated file
    file.writeAsStringSync(buffer.toString());
  }
}
