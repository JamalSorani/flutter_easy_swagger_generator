import 'dart:io';

import '../classes/components.dart';
import '../classes/dart_type_info.dart';
import '../classes/http_method_info.dart';
import '../classes/parameter.dart';
import '../classes/property.dart';
import '../classes/request_body.dart';
import '../helpers/converters.dart';
import '../helpers/dart_type.dart';
import '../helpers/utils.dart';
import 'class_serializer_generator.dart';

class ClassGenerator {
  final List<String> moduleList;
  final Components components;
  final bool isForEntities;

  ClassGenerator(
      {required this.moduleList,
      required this.components,
      required this.isForEntities});

  void generateClass(String key, Map<String, HttpMethodInfo> path) {
    String endPoint = isForEntities ? 'Param' : 'Model';
    String routeName = getRouteName(key);
    String className = '$routeName$endPoint';

    String moduleName = getCategory(key);
    String filePath =
        getModelAndEntityFilePath(moduleName, routeName, isForEntities);
    List<String> contents = [];
    Set<String> refSchemas = {};
    StringBuffer classBuffer = StringBuffer();

    classBuffer.writeln();

    for (var httpMethodInfo in path.values) {
      String classContent = _generateClassContent(
        className: className,
        parameters: httpMethodInfo.parameters,
        requestBody: httpMethodInfo.requestBody,
        classBuffer: classBuffer,
      );
      contents.add(classContent);
      refSchemas = _collectRefSchemas(httpMethodInfo.parameters, refSchemas);
      refSchemas = _collectRefSchemas(
          httpMethodInfo.requestBody?.content?.values.toList(), refSchemas);
    }

    final file = File(filePath);
    file.parent.createSync(recursive: true);

    for (var content in contents) {
      file.writeAsStringSync(content);
    }

    // Generate referenced types
    for (var refSchema in refSchemas) {
      String refClassName = _getRefClassName(refSchema);
      String refFilePath =
          getModelAndEntityFilePath(moduleName, refClassName, true);
      String refContent = _generateRefClass(refSchema, refClassName);
      if (refContent.isNotEmpty) {
        File(refFilePath).writeAsStringSync(refContent);

        // Also generate nested references
        final schema = components.schemas[refSchema.split('/').last];
        if (schema is ObjectProperty && schema.properties != null) {
          Set<String> nestedRefs = {};
          for (var prop in schema.properties!.values) {
            if (prop.ref != null) {
              nestedRefs.add(prop.ref!);
            }
            if (prop is ArrayProperty && prop.items?.ref != null) {
              nestedRefs.add(prop.items!.ref!);
            }
          }
          for (var nestedRef in nestedRefs) {
            String nestedRefClassName = _getRefClassName(nestedRef);
            String nestedRefFilePath =
                getModelAndEntityFilePath(moduleName, nestedRefClassName, true);
            String nestedRefContent =
                _generateRefClass(nestedRef, nestedRefClassName);
            if (nestedRefContent.isNotEmpty) {
              File(nestedRefFilePath).writeAsStringSync(nestedRefContent);
            }
          }
        }
      }
    }
  }

  String _getRefClassName(String refSchema) {
    final ref = refSchema.split('/').last.split('.');
    String name = ref.last.toString().toLowerCase() == "request"
        ? ref[ref.length - 2]
        : ref.last;

    // Handle shared types
    if (refSchema.contains('.Shared.')) {
      return name;
    }

    return name;
  }

  String _generateRefClass(String refSchema, String className) {
    StringBuffer buffer = StringBuffer();

    // Get schema from components
    final schema = components.schemas[refSchema.split('/').last];
    if (schema == null) {
      return '';
    }

    // Handle enums
    if (schema is PrimitiveProperty &&
        schema.type == 'string' &&
        schema.enumValues != null) {
      buffer.writeln('enum $className {');
      for (var value in schema.enumValues!) {
        value = toCamelCase(value);
        if (value == "new") {
          value = "neww";
        }
        buffer.writeln('  $value,');
      }
      buffer.writeln('}');
      return buffer.toString();
    }

    List<String> properties = [];
    if (schema is ObjectProperty && schema.properties != null) {
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        TProperty prop = entry.value;

        DartTypeInfo dartType = getDartType(prop, components);

        if (dartType.isRef && prop.ref != null) {
          String refClassName = _getRefClassName(prop.ref!);
          String fileName = convertToSnakeCase(refClassName);
          buffer.writeln(
              'import \'${fileName}${isForEntities ? '_param' : '_model'}.dart\';');
        }

        String propType = dartType.className;
        if (prop is ArrayProperty) {
          if (prop.items?.ref != null) {
            String itemRefClassName = _getRefClassName(prop.items!.ref!);
            String fileName = convertToSnakeCase(itemRefClassName);
            buffer.writeln(
                'import \'${fileName}${isForEntities ? '_param' : '_model'}.dart\';');
            propType = 'List<$itemRefClassName>';
          } else if (prop.items is PrimitiveProperty &&
              (prop.items as PrimitiveProperty).type == 'string' &&
              (prop.items as PrimitiveProperty).format == 'binary') {
            propType = 'List<String>';
          } else {
            propType = 'List<${getDartType(prop.items, components).className}>';
          }
        }

        String nullableSuffix = prop.nullable == true ? '?' : '';
        String camelCaseFieldName =
            toCamelCase(propName.replaceAll('.', '').replaceAll("/", ""));
        properties.add('  final $propType$nullableSuffix $camelCaseFieldName;');
      }
    }

    buffer.writeln('class $className {');
    for (final prop in properties) {
      buffer.writeln(prop);
    }
    buffer.writeln();

    if (schema is ObjectProperty && schema.properties != null) {
      buffer.writeln('  $className({');
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        String camelCaseFieldName =
            toCamelCase(propName.replaceAll('.', '').replaceAll("/", ""));
        buffer.writeln('    required this.$camelCaseFieldName,');
      }
      buffer.writeln('  });');

      buffer.writeln('''
  Map<String, dynamic> toJson() {
    return {
''');
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        String camelCaseFieldName = toCamelCase(propName.replaceAll('.', ''));
        buffer.writeln('      \'$propName\': $camelCaseFieldName,');
      }
      buffer.writeln('''
    };
  }
''');
    }

    buffer.writeln('}');
    return buffer.toString();
  }

  Set<String> _collectRefSchemas(
      List<dynamic>? parameters, Set<String> refSchemas) {
    if (parameters != null) {
      for (var param in parameters) {
        if (param?.schema?.ref != null) {
          refSchemas.add(param.schema.ref);
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

  String _generateClassContent({
    required String className,
    required List<IParameter>? parameters,
    required TRequestBody? requestBody,
    required StringBuffer classBuffer,
  }) {
    List<String> parameterDeclarations = [];
    List<String> requiredParams = [];

    // Process parameters
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
          classBuffer.writeln(
              'import \'${convertToSnakeCase(refClassName)}${isForEntities ? '_param' : '_model'}.dart\';');
        }
        String paramType = dartTypeInfo.className;
        if (paramName.contains(".")) {
          paramName = paramName.replaceAll('.', '');
        }
        parameterDeclarations.add(
            '  final $paramType ${toCamelCase(paramName).replaceAll("/", "")};');
        requiredParams
            .add('required this.${toCamelCase(paramName).replaceAll("/", "")}');
      }
    }

    // Process request body
    if (requestBody?.content != null) {
      for (var prop in requestBody!.content!.keys) {
        bool isRef = false;

        // Handle special content types
        if (prop == "application/json" || prop == "multipart/form-data") {
          if (requestBody.content![prop]?.schema == null) {
            continue;
          }

          // Check if it's a reference
          if (requestBody.content![prop]?.schema?.ref != null) {
            isRef = true;
          }
        } else if (requestBody.content![prop]?.schema == null ||
            prop.contains("/")) {
          // Skip other content types without schema
          continue;
        }

        // For multipart/form-data, we need to handle the properties differently
        if (prop == "multipart/form-data" &&
            requestBody.content![prop]?.schema is ObjectProperty) {
          ObjectProperty schema =
              requestBody.content![prop]!.schema as ObjectProperty;
          if (schema.properties != null) {
            for (var entry in schema.properties!.entries) {
              String fieldName = entry.key;
              TProperty fieldSchema = entry.value;

              String fieldType;
              if (fieldSchema is ArrayProperty) {
                if (fieldSchema.items?.ref != null) {
                  String itemRefClassName =
                      _getRefClassName(fieldSchema.items!.ref!);
                  classBuffer.writeln(
                      'import \'${convertToSnakeCase(itemRefClassName)}${isForEntities ? '_param' : '_model'}.dart\';');
                  fieldType = 'List<$itemRefClassName>';
                } else if (fieldSchema.items is PrimitiveProperty &&
                    (fieldSchema.items as PrimitiveProperty).type == 'string' &&
                    (fieldSchema.items as PrimitiveProperty).format ==
                        'binary') {
                  fieldType = 'List<String>';
                } else {
                  fieldType =
                      'List<${getDartType(fieldSchema.items, components).className}>';
                }
              } else {
                DartTypeInfo fieldTypeInfo =
                    getDartType(fieldSchema, components);
                fieldType = fieldTypeInfo.className;

                if (fieldSchema.ref != null) {
                  String refClassName = _getRefClassName(fieldSchema.ref!);
                  classBuffer.writeln(
                      'import \'${convertToSnakeCase(refClassName)}${isForEntities ? '_param' : '_model'}.dart\';');
                  fieldType = refClassName;
                }
              }

              String nullableSuffix = fieldSchema.nullable == true ? '?' : '';
              String camelCaseFieldName =
                  toCamelCase(fieldName.replaceAll('.', ''));
              parameterDeclarations.add(
                  '  final $fieldType$nullableSuffix ${camelCaseFieldName.replaceAll("/", "")};');
              requiredParams.add(
                  'required this.${camelCaseFieldName.replaceAll("/", "")}');
            }
          }
        } else {
          DartTypeInfo dartTypeInfo =
              getDartType(requestBody.content![prop]?.schema, components);
          if (dartTypeInfo.isRef) {
            String refClassName =
                _getRefClassName(requestBody.content![prop]!.schema!.ref!);
            classBuffer.writeln(
                'import \'${convertToSnakeCase(refClassName)}${isForEntities ? '_param' : '_model'}.dart\';');
          }

          String propType = dartTypeInfo.className;
          String propName = prop;

          if (prop.contains(".")) {
            propName = prop.replaceAll('.', '');
          }

          parameterDeclarations.add(
              '  final $propType ${toCamelCase(isRef ? propType : propName).replaceAll("/", "")};');
          requiredParams.add(
              'required this.${toCamelCase(isRef ? propType : propName).replaceAll("/", "")}');
        }
      }
    }

    // Generate class
    classBuffer.writeln('class $className {');
    for (var declaration in parameterDeclarations) {
      classBuffer.writeln(declaration);
    }

    final classSerializerGenerator = ClassSerializerGenerator(
      classBuffer: classBuffer,
      className: className,
      components: components,
    );

    classSerializerGenerator.generateConstructure(requiredParams);

    classSerializerGenerator.genereateToJson(parameters, requestBody);
    return classBuffer.toString();
  }
}
