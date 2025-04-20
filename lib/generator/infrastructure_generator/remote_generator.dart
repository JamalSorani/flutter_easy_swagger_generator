import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/components.dart';
import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';
import 'package:flutter_easy_swagger_generator/helpers/converters.dart';
import '../../helpers/printer.dart';
import '../../helpers/utils.dart';

class RemoteGenerator {
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;
  final List<String> moduleList;

  RemoteGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
  });

  void generateRemote() {
    try {
      Map<String, List<MapEntry<String, Map<String, HttpMethodInfo>>>>
          groupedPaths = {};

      for (var path in paths.entries) {
        String category = getCategory(path.key);
        if (!groupedPaths.containsKey(category)) {
          groupedPaths[category] = [];
        }
        groupedPaths[category]!.add(MapEntry(path.key, path.value));
      }

      for (var category in groupedPaths.keys) {
        _generateRemoteForCategory(category, groupedPaths[category]!);
      }
    } catch (e) {
      printError('Error while generating repositories: $e');
    }
  }

  void _generateRemoteForCategory(
    String category,
    List<MapEntry<String, Map<String, HttpMethodInfo>>> categoryPaths,
  ) {
    String filePath =
        'lib/app/$category/infrastructure/datasource/remote/${category}_api.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("import 'package:dio/dio.dart';");
    buffer.writeln("import '../../../../generated_routes.dart';");
    buffer.writeln(
        "import '../../../../../common/network/exception/error_handler.dart';");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);

      buffer.writeln("import '../../models/${actionName}_model.dart';");
    }

    // Add entity imports
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);
      buffer.writeln(
          "import '../../../domain/entities/${actionName}_param.dart';");
    }

    buffer.writeln();

    buffer.writeln(
        "class ${(category[0].toUpperCase() + category.substring(1))}Api {");
    buffer.writeln("  final Dio _dio;");

    buffer.writeln(
        "  const ${(category[0].toUpperCase() + category.substring(1))}Api(Dio dio) : _dio = dio;");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;

      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);
        String requestType = method.key;
        buffer.writeln("""
  Future<${actionName}Model> $methodName({
    required ${actionName}Param ${methodName}Param,
  }) {
    return throwDioException(() async {
      final response = await _dio.$requestType(
        AppUrl.${actionName[0].toLowerCase() + actionName.substring(1)},
        data: ${methodName}Param.toJson(),
      );
      return ${actionName}Model.fromJson(response.data);
    });
  }
""");
      }
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
