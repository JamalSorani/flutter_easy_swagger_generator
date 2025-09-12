import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';

import '../../helpers/create_folder.dart';
import '../../helpers/printer.dart';
import '../../helpers/utils.dart';

/// A generator class that creates a Dart class containing all API routes.
///
/// It reads the Swagger paths and generates a class `AppUrl`
/// with static constants for each route, grouped by category.
class RoutesGenerator {
  /// The main directory path where the generated file will be saved.
  final String mainPath;

  /// A map containing all API paths with their HTTP method information.
  Map<String, Map<String, HttpMethodInfo>> paths;

  /// Constructor for [RoutesGenerator].
  ///
  /// Requires [paths] and [mainPath].
  RoutesGenerator({required this.paths, required this.mainPath});

  /// Generates the `AppUrl` Dart class containing all API routes.
  ///
  /// Routes are grouped by category and formatted as static constants.
  /// Each route has the `/api/` prefix removed.
  void generateRoutes() {
    try {
      // Group routes by category
      Map<String, List<String>> groupedRoutes = {};
      for (var path in paths.keys) {
        // Generate a camelCase action name from the route
        String actionName = getRouteName(path);
        actionName = actionName[0].toLowerCase() + actionName.substring(1);

        // Determine the category of the route
        String category = getCategory(path);

        // Format the route as a static constant
        String formattedRoute =
            "  static const String $actionName = '${path.replaceAll('/api/', '')}';";

        groupedRoutes.putIfAbsent(category, () => []).add(formattedRoute);
      }

      // Format grouped routes with comments indicating the category
      List<String> formattedGroups = [];
      groupedRoutes.forEach((category, routes) {
        formattedGroups.add(
            "//! $category ===================================================================");
        formattedGroups.addAll(routes);
        formattedGroups.add(
            "//! $category ===================================================================\n");
      });

      // Combine everything into the final Dart class
      final generatedClass = '''
/// This class contains all API routes as static constants,
/// grouped by category.
class AppUrl {
${formattedGroups.join('\n')}
}
''';

      // Ensure the output folder exists
      createFolder(mainPath);

      // Write the generated class to a Dart file
      final outputFile = File("$mainPath/url.dart");
      outputFile.writeAsStringSync(generatedClass);
    } catch (e) {
      printError('Error while generating routes: $e');
    }
  }
}
