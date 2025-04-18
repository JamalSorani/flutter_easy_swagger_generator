import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/components.dart';
import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';
import 'package:flutter_easy_swagger_generator/helpers/converters.dart';
import '../../helpers/utils.dart';

class RepositoryGenerator {
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;
  final List<String> moduleList;

  RepositoryGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
  });

  void generateRepository() {
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
        _generateRepositoryForCategory(category, groupedPaths[category]!);
      }
    } catch (e) {
      print('Error while generating repositories: $e');
    }
  }

  void _generateRepositoryForCategory(
    String category,
    List<MapEntry<String, Map<String, HttpMethodInfo>>> categoryPaths,
  ) {
    String filePath =
        'lib/app/$category/domain/repository/${category}_repository.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("import 'package:either_dart/either.dart';");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);

      buffer.writeln(
          "import '../../infrastructure/models/${actionName}_model.dart';");
    }

    // Add entity imports
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);
      buffer.writeln("import '../entities/${actionName}_param.dart';");
    }

    buffer.writeln();

    buffer.writeln(
        "abstract class ${(category[0].toUpperCase() + category.substring(1))}Repository {");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;

      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);
        buffer.writeln(
            "  Future<Either<String, ${actionName}Model>> $methodName({required ${actionName}Param ${methodName}Param,});");
        buffer.writeln();
      }
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
