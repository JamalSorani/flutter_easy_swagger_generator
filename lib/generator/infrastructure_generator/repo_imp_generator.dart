import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/components.dart';
import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';
import 'package:flutter_easy_swagger_generator/helpers/converters.dart';
import '../../helpers/printer.dart';
import '../../helpers/utils.dart';

class RepoImpGenerator {
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;
  final List<String> moduleList;

  RepoImpGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
  });

  void generateRepoImp() {
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
      printError('Error while generating repo imp: $e');
    }
  }

  void _generateRepositoryForCategory(
    String category,
    List<MapEntry<String, Map<String, HttpMethodInfo>>> categoryPaths,
  ) {
    String filePath =
        'lib/app/$category/infrastructure/repo_imp/${category}_repo_imp.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("import 'package:either_dart/either.dart';");
    buffer.writeln(
        "import '../../domain/repository/${category}_repository.dart';");
    buffer.writeln(
        "import '../../../../common/network/exception/error_handler.dart';");
    buffer.writeln("import '../datasource/remote/${category}_api.dart';");
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);

      buffer.writeln("import '../models/${actionName}_model.dart';");
    }

    // Add entity imports
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);
      buffer
          .writeln("import '../../domain/entities/${actionName}_param.dart';");
    }

    buffer.writeln();
    String className = category[0].toUpperCase() + category.substring(1);
    buffer.writeln(
        "class ${className}RepoImp implements ${className}Repository {");
    buffer.writeln("  final ${className}Api _api;");
    buffer.writeln(
        "  ${className}RepoImp({required ${className}Api api}) : _api = api;");
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;
      buffer.writeln();
      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);
        buffer.writeln("  @override");
        buffer.writeln("""
  Future<Either<String, ${actionName}Model>> $methodName({
    required ${actionName}Param ${methodName}Param,
  }) {
    return throwAppException(() async {
      final response = await _api.$methodName(
        ${methodName}Param: ${methodName}Param,
      );
      return response;
    });
  }""");
      }
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
