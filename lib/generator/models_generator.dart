import 'dart:io';

import 'package:flutter_easy_swagger_generator/type/components.dart';

import '../helpers/constants.dart';
import '../helpers/converters.dart';
import '../helpers/create_folder.dart';
import '../helpers/format_action_name.dart';
import '../type/http_method_info.dart';
import '../type/parameter.dart';
import '../type/request_body.dart';

class ModelsGenerator {
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;

  ModelsGenerator({required this.paths, required this.components});
  void generateModels() {
    Set<String> categories = {};
    for (var path in paths.keys) {
      String category = _getCategory(path);
      categories.add(category);
    }

    for (var category in categories) {
      String categoryFolderPath = 'lib/$category';

      // Create entities folder
      String entitiesFolderPath = '$categoryFolderPath/domain/entities';
      createFolder(entitiesFolderPath);

      // Create models folder
      String modelsFolderPath = '$categoryFolderPath/infrastructure/models';
      createFolder(modelsFolderPath);

      _generateParameterClasses(
          paths, category, entitiesFolderPath, components);
    }
  }

  String _getCategory(String path) {
    path = cleanPath(path);
    List<String> parts = path.split('/');
    if (parts.isEmpty) return generalCategory;
    if (parts.first.toLowerCase() == 'dashboard') {
      parts.removeAt(0);
    }
    return parts.isNotEmpty ? parts.first.toLowerCase() : generalCategory;
  }

  void _generateParameterClasses(Map<String, Map<String, HttpMethodInfo>> paths,
      String category, String entitiesFolderPath, Components components) {
    for (var path in paths.keys) {
      if (_getCategory(path) == category) {
        for (var method in paths[path]!.keys) {
          String routeName = _getRouteName(path);
          String className = '${routeName}Param';
          String fileName = _getFileName(category, routeName);
          String filePath = '$entitiesFolderPath/$fileName.dart';

          List<IParameter> parameters = [];
          if (paths[path]![method]?.parameters != null) {
            parameters = paths[path]![method]!.parameters!;
          }

          // IProperty? requestBody;
          // if (paths[path]?[method]?.requestBody != null) {
          //   requestBody = _extractRequestBody(
          //       paths[path]![method]!.requestBody!, components);
          // }

          String classContent = _generateClassContent(
              className, parameters, paths[path]![method]!.requestBody);

          File(filePath).writeAsStringSync(classContent);
        }
      }
    }
  }

  // IProperty? _extractRequestBody(
  //     IRequestBody requestBody, Components components) {
  //   if (requestBody.content?.containsKey('content') == true) {
  //     for (var contentType in requestBody.content!.values) {
  //       IProperty? schema = contentType.schema;
  //       return schema;
  //     }
  //   }
  //   return null;
  // }

  String _generateClassContent(String className, List<IParameter> parameters,
      IRequestBody? requestBody) {
    StringBuffer classBuffer = StringBuffer();
    classBuffer.writeln('class $className {');

    // Collecting parameter declarations and constructor parameters
    List<String> parameterDeclarations = [];
    List<String> requiredParams = [];

    for (var param in parameters) {
      String paramName = param.name;
      if (paramName == 'X-TimeZoneId' ||
          paramName == 'lang' ||
          paramName == 'DebugMode') {
        continue;
      }
      String paramType = _getDartType(param.schema?.type ?? param.name);
      // Ensure parameter names are lowercase
      parameterDeclarations
          .add('  final $paramType ${toCamelCase(paramName)};');
      requiredParams.add('required this.${toCamelCase(paramName)}');
    }
    if (requestBody?.content != null) {
      for (var prop in requestBody!.content!.keys) {
        String propType =
            _getDartType(requestBody.content![prop]!.schema?.type);
        parameterDeclarations.add('  final $propType ${toCamelCase(prop)};');
        requiredParams
            .add('required this.${toCamelCase(prop)}'); // Use lowercase
      }
    }

    // Write parameter declarations
    for (var declaration in parameterDeclarations) {
      classBuffer.writeln(declaration);
    }

    // Adjust the constructor to handle empty classes
    classBuffer.write('  $className({');
    if (requiredParams.isNotEmpty) {
      classBuffer.write(requiredParams.join(', '));
    }
    classBuffer.writeln('});');

    classBuffer.writeln('''
  Map<String, dynamic> toJson() {
    return {
''');

    for (var param in parameters) {
      String paramName = param.name;
      if (paramName == 'X-TimeZoneId' ||
          paramName == 'lang' ||
          paramName == 'DebugMode') {
        continue;
      }

      classBuffer.writeln("      '$paramName': ${toCamelCase(paramName)},");
    }
    if (requestBody?.content != null) {
      for (var prop in requestBody!.content!.keys) {
        classBuffer.writeln("      '$prop': ${toCamelCase(prop)},");
      }
    }
    classBuffer.writeln('''
    };
  }
  ''');

    classBuffer.writeln('}');
    return classBuffer.toString();
  }

  String _getDartType(String? swaggerType) {
    switch (swaggerType) {
      case 'string':
        return 'String';
      case 'integer':
        return 'int';
      case 'number':
        return 'double';
      case 'boolean':
        return 'bool';
      default:
        return 'dynamic';
    }
  }

  String _getRouteName(String path) {
    path = cleanPath(path);
    List<String> parts = path.split('/');
    if (parts.isEmpty) return generalCategory;
    if (parts.first.toLowerCase() == 'dashboard') {
      parts.removeAt(0);
    }
    return parts.map((e) => e[0].toUpperCase() + e.substring(1)).join('');
  }

  String _getFileName(String category, String routeName) {
    String snakeCaseRoute = convertToSnakeCase(routeName);
    if (snakeCaseRoute.startsWith('${category}_')) {
      snakeCaseRoute = snakeCaseRoute.substring(category.length + 1);
    }
    return '${snakeCaseRoute}_${category}_param';
  }
}
