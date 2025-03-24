import 'dart:developer';
import 'dart:io';

import 'package:flutter_easy_swagger_generator/type/http_method_info.dart';

import '../helpers/create_folder.dart';
import '../helpers/format_action_name.dart';
import '../helpers/utils.dart';

class RoutesGenerator {
  Map<String, Map<String, HttpMethodInfo>> paths;
  RoutesGenerator({required this.paths});

  /// 📌 Parses Swagger JSON and generates a Dart class with grouped API route constants.
  void generateRoutes() {
    try {
      Map<String, List<String>> groupedRoutes = {};
      for (var path in paths.keys) {
        String actionName = formatActionName(path);
        String category = PathUtils.getCategory(path);
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
${formattedGroups.join('\n')}
}
''';
      String folderPath = 'lib/app';
      createFolder(folderPath);
      final outputFile = File("$folderPath/generated_routes.dart");
      outputFile.writeAsStringSync(generatedClass);
      log('✅ Routes generated successfully: $folderPath/generated_routes.dart');
    } catch (e) {
      log('Error while generating routes: $e');
    }
  }
}
