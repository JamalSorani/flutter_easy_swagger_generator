import 'dart:io';

import '../classes/parameter.dart';
import '../classes/request_body.dart';
import '../helpers/converters.dart';
import '../helpers/dart_type.dart';
import '../helpers/utils.dart';
import '../classes/http_method_info.dart';

class EntitiesGenerator {
  final List<String> moduleList;
  final Map<String, Map<String, HttpMethodInfo>> paths;
  EntitiesGenerator({required this.moduleList, required this.paths});

  generateEntities() {
    paths.map(
      (key, value) {
        _generateEntityFile(key, value);

        return MapEntry(key, value);
      },
    );
  }

  void _generateEntityFile(String key, Map<String, HttpMethodInfo> path) {
    String routeName = getRouteName(key);
    String className = '${routeName}Param';
    String moduleName =
        key.split('/').firstWhere((p) => moduleList.contains(p.toLowerCase()));
    String fileName = getFileName(moduleName, routeName);
    String filePath = 'lib/app/$moduleName/domain/entities/$fileName.dart';

    List<String> contents = [];
    for (var httpMethodInfo in path.values) {
      contents.add(
        _generateClassContent(
          className,
          httpMethodInfo.parameters,
          httpMethodInfo.requestBody,
        ),
      );
    }

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    for (var content in contents) {
      file.writeAsStringSync(content);
    }
  }

  String _generateClassContent(
    String className,
    List<IParameter>? parameters,
    TRequestBody? requestBody,
  ) {
    StringBuffer classBuffer = StringBuffer();
    classBuffer.writeln('class $className {');

    // Collecting parameter declarations and constructor parameters
    List<String> parameterDeclarations = [];
    List<String> requiredParams = [];
    if (parameters != null) {
      for (var param in parameters) {
        String paramName = param.name;
        if (paramName == 'X-TimeZoneId' ||
            paramName == 'lang' ||
            paramName == 'DebugMode') {
          continue;
        }
        String paramType = getDartType(param.schema?.type ?? param.type);
        if (paramName.contains(".")) {
          paramName = paramName.replaceAll('.', '');
        }
        parameterDeclarations
            .add('  final $paramType ${toCamelCase(paramName)};');
        requiredParams.add('required this.${toCamelCase(paramName)}');
      }
    }
    if (requestBody?.content != null) {
      for (var prop in requestBody!.content!.keys) {
        if (requestBody.content![prop]?.schema == null || prop.contains("/")) {
          continue;
        }
        String propType = getDartType(requestBody.content![prop]?.schema?.type);
        if (prop.contains(".")) {
          prop = prop.replaceAll('.', '');
        }
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
    _generateConstructure(classBuffer, className, requiredParams);
    _generateToJson(classBuffer, parameters, requestBody);
    classBuffer.writeln('}');
    return classBuffer.toString();
  }

  _generateConstructure(
      StringBuffer classBuffer, String className, List<String> requiredParams) {
    if (requiredParams.isNotEmpty) {
      classBuffer.write('  $className({');
      classBuffer.write(requiredParams.join(', '));
      classBuffer.writeln('});');
    }
  }

  _generateToJson(
    StringBuffer classBuffer,
    List<IParameter>? parameters,
    TRequestBody? requestBody,
  ) {
    classBuffer.writeln('''
  Map<String, dynamic> toJson() {
    return {
''');
    if (parameters != null) {
      for (var param in parameters) {
        String paramName = param.name;
        if (paramName == 'X-TimeZoneId' ||
            paramName == 'lang' ||
            paramName == 'DebugMode') {
          continue;
        }
        final paramName2 = paramName.replaceAll(".", "");

        classBuffer.writeln("      '$paramName': ${toCamelCase(paramName2)},");
      }
    }
    if (requestBody?.content != null) {
      for (var prop in requestBody!.content!.keys) {
        if (requestBody.content![prop]?.schema == null || prop.contains("/")) {
          continue;
        }
        final prop2 = prop.replaceAll(".", "");
        classBuffer.writeln("      '$prop': ${toCamelCase(prop2)},");
      }
    }
    classBuffer.writeln('''
    };
  }
  ''');
  }
}
