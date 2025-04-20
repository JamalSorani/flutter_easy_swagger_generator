import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';

import '../../helpers/create_folder.dart';
import '../../helpers/printer.dart';
import '../../helpers/utils.dart';

class RoutesGenerator {
  final String mainPath;
  Map<String, Map<String, HttpMethodInfo>> paths;
  RoutesGenerator({required this.paths, required this.mainPath});

  /// 📌 Parses Swagger JSON and generates a Dart class with grouped API route constants.
  void generateRoutes() {
    try {
      Map<String, List<String>> groupedRoutes = {};
      for (var path in paths.keys) {
        String actionName = getRouteName(path);
        actionName = actionName[0].toLowerCase() + actionName.substring(1);
        String category = getCategory(path);
        String formattedRoute =
            "  static const String $actionName = '${path.replaceAll('/api/', '')}';";
        groupedRoutes.putIfAbsent(category, () => []).add(formattedRoute);
      }

      List<String> formattedGroups = [];
      groupedRoutes.forEach((category, routes) {
        formattedGroups.add(
            "//****************************** $category ************************************/");
        formattedGroups.addAll(routes);
        formattedGroups.add(
            "//****************************** $category ************************************/\n");
      });

      final generatedClass = '''
/// 🚀 API Routes
///
/// This class contains all API route constants extracted from the Swagger JSON.
class AppUrl {
${formattedGroups.join('\n')}}
''';
      createFolder(mainPath);
      final outputFile = File("$mainPath/generated_routes.dart");
      outputFile.writeAsStringSync(generatedClass);
    } catch (e) {
      printError('Error while generating routes: $e');
    }
  }
}
