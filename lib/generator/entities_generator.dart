import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/printer.dart';

import '../classes/parameter.dart';
import '../classes/request_body.dart';
import '../helpers/converters.dart';
import '../helpers/dart_type.dart';
import '../helpers/utils.dart';
import '../classes/http_method_info.dart';
import '../classes/dart_type_info.dart';
import '../classes/components.dart';
import '../classes/property.dart';

class EntitiesGenerator {
  final List<String> moduleList;
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;
  EntitiesGenerator({
    required this.moduleList,
    required this.paths,
    required this.components,
  });

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
    if (className == "CategoryAddParam") {
      printP(key);
    }
    String moduleName =
        key.split('/').firstWhere((p) => moduleList.contains(p.toLowerCase()));
    String fileName = getFileName(moduleName, routeName);
    String filePath = 'lib/app/$moduleName/domain/entities/$fileName.dart';

    List<String> contents = [];
    Set<String> refSchemas = {};
    StringBuffer classBuffer = StringBuffer();

    // Add imports
    classBuffer.writeln();

    for (var httpMethodInfo in path.values) {
      String classContent = _generateClassContent(className,
          httpMethodInfo.parameters, httpMethodInfo.requestBody, classBuffer);
      contents.add(classContent);
      refSchemas = _collectRefSchemas(httpMethodInfo.parameters, refSchemas);
      refSchemas = _collectRefSchemas(
          httpMethodInfo.requestBody?.content?.values.toList(), refSchemas);
    }

    final file = File(filePath);
    file.parent.createSync(recursive: true);

    // Write main class content
    for (var content in contents) {
      file.writeAsStringSync(content);
    }

    // Generate and write ref classes
    for (var refSchema in refSchemas) {
      String refClassName = _getRefClassName(refSchema);
      String refFilePath = _refDomainClassFilePath(moduleName, refClassName);
      String refContent = _generateRefClass(refSchema, refClassName);
      if (refContent.isNotEmpty) {
        File(refFilePath).writeAsStringSync(refContent);
      }
    }
  }

  String _refDomainClassFilePath(String moduleName, String refClassName) {
    return 'lib/app/$moduleName/domain/entities/${convertToSnakeCase(refClassName)}.dart';
  }

  String _getRefClassName(String refSchema) {
    final ref = refSchema.split('/').last.split('.');
    String name = ref.last.toString().toLowerCase() == "request"
        ? ref[ref.length - 2]
        : ref.last;

    return name;
  }

  String _generateRefClass(String refSchema, String className) {
    StringBuffer buffer = StringBuffer();

    // Get schema from components
    final schema = components.schemas[refSchema.split('/').last];
    if (schema == null) {
      return '';
    }
    List<String> properties = [];
    // Generate properties
    if (schema is ObjectProperty && schema.properties != null) {
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        TProperty prop = entry.value;

        DartTypeInfo dartType = getDartType(prop, components);

        if (dartType.isRef) {
          String refClassName = _getRefClassName(prop.ref!);
          buffer
              .writeln('import \'${convertToSnakeCase(refClassName)}.dart\';');
        }
        String propType = dartType.className;

        // Handle nullable properties
        String nullableSuffix = prop.nullable == true ? '?' : '';

        properties
            .add('  final $propType$nullableSuffix ${toCamelCase(propName)};');
      }
    }
    buffer.writeln('class $className {');
    for (final prop in properties) {
      buffer.writeln(prop);
    }
    // Generate constructor
    buffer.writeln();
    if (schema is ObjectProperty && schema.properties != null) {
      buffer.writeln('  $className({');
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        buffer.writeln('    required this.${toCamelCase(propName)},');
      }
      buffer.writeln('  });');
    }

    // Generate fromJson and toJson methods

    buffer.writeln('''
  Map<String, dynamic> toJson() {
    return {
''');
    if (schema is ObjectProperty && schema.properties != null) {
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        String camelCaseName = toCamelCase(propName);
        buffer.writeln('      \'$propName\': $camelCaseName,');
      }
    }
    buffer.writeln('''
    };
  }
''');

    buffer.writeln('}');
    return buffer.toString();
  }

  Set<String> _collectRefSchemas(
      List<dynamic>? parameters, Set<String> refSchemas) {
    if (parameters != null) {
      for (var param in parameters) {
        if (param?.schema?.ref != null) {
          refSchemas.add(param.schema.ref);
          // Also collect nested refs if it's an object property
          if (param.schema is ObjectProperty) {
            refSchemas =
                _collectNestedRefs(param.schema as ObjectProperty, refSchemas);
          }
        }
      }
    }
    return refSchemas;
  }

  Set<String> _collectNestedRefs(
      ObjectProperty property, Set<String> refSchemas) {
    if (property.properties != null) {
      for (var prop in property.properties!.values) {
        if (prop.ref != null) {
          refSchemas.add(prop.ref!);
          if (prop is ObjectProperty) {
            refSchemas = _collectNestedRefs(prop, refSchemas);
          }
        }
      }
    }
    return refSchemas;
  }

  String _generateClassContent(String className, List<IParameter>? parameters,
      TRequestBody? requestBody, StringBuffer classBuffer) {
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
        DartTypeInfo dartTypeInfo = getDartType(param.schema, components);
        if (dartTypeInfo.isRef) {
          String refClassName = _getRefClassName(param.schema!.ref!);
          classBuffer
              .writeln('import \'${convertToSnakeCase(refClassName)}.dart\';');
        }
        String paramType = dartTypeInfo.className;
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
        bool isRef = false;
        if (requestBody.content![prop]?.schema == null ||
            (prop.contains("/"))) {
          if (requestBody.content![prop]?.schema?.ref == null) {
            continue;
          } else {
            if (className == "CategoryAddParam") {
              printP((requestBody.content![prop]?.schema as RefProperty).ref);
            }
            if (prop == "application/json") {
              isRef = true;
            } else {
              continue;
            }
          }
        }
        DartTypeInfo dartTypeInfo =
            getDartType(requestBody.content![prop]?.schema, components);
        if (dartTypeInfo.isRef) {
          String refClassName =
              _getRefClassName(requestBody.content![prop]!.schema!.ref!);
          classBuffer
              .writeln('import \'${convertToSnakeCase(refClassName)}.dart\';');
        }

        String propType = dartTypeInfo.className;
        if (isRef && className == "CategoryAddParam") {
          printO(requestBody.content![prop]?.schema!.ref);
        }
        if (prop.contains(".")) {
          prop = prop.replaceAll('.', '');
        }
        parameterDeclarations
            .add('  final $propType ${toCamelCase(isRef ? propType : prop)};');
        requiredParams
            .add('required this.${toCamelCase(isRef ? propType : prop)}');
      }
    }
    classBuffer.writeln('class $className {');

    // Write parameter declarations
    for (var declaration in parameterDeclarations) {
      classBuffer.writeln(declaration);
    }

    // Generate constructor
    _generateConstructure(classBuffer, className, requiredParams);

    _genereateToJson(classBuffer, parameters, requestBody, className);
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

  _genereateToJson(
    StringBuffer classBuffer,
    List<IParameter>? parameters,
    TRequestBody? requestBody,
    String className,
  ) {
    bool isWritingStarted = false;
    if (parameters != null) {
      for (var param in parameters) {
        String paramName = param.name;
        if (paramName == 'X-TimeZoneId' ||
            paramName == 'lang' ||
            paramName == 'DebugMode') {
          continue;
        }
        String camelCaseName = toCamelCase(paramName.replaceAll('.', ''));
        if (!isWritingStarted) {
          classBuffer.writeln('''
  Map<String, dynamic> toJson() {
    return {
''');
          isWritingStarted = true;
        }
        classBuffer.writeln('      \'$paramName\': $camelCaseName,');
      }
    }
    if (requestBody?.content != null) {
      for (var prop in requestBody!.content!.keys) {
        bool isRef = false;
        if (requestBody.content![prop]?.schema == null || prop.contains("/")) {
          if (requestBody.content![prop]?.schema?.ref == null) {
            continue;
          } else {
            if (className == "CategoryAddParam") {
              printP((requestBody.content![prop]?.schema as RefProperty).ref);
            }
            if (prop == "application/json") {
              isRef = true;
            } else {
              continue;
            }
          }
        }
        if (isRef) {
          DartTypeInfo dartTypeInfo =
              getDartType(requestBody.content![prop]?.schema, components);
          String propType = dartTypeInfo.className;

          classBuffer.write('''
 Map<String, dynamic> toJson() {
    return
          ${toCamelCase(propType)}.toJson();
          }    
        }
          ''');
          return;
        } else {
          String camelCaseName = toCamelCase(prop.replaceAll('.', ''));
          classBuffer.writeln('      \'$prop\': $camelCaseName,');
        }
      }
    }
    if (isWritingStarted) {
      classBuffer.writeln('''
    };
  }
''');
    }

    classBuffer.writeln('}');
  }
}
