import 'dart:io';

import '../../classes/components.dart';
import '../../classes/http_method_info.dart';
import '../../classes/parameter.dart';
import '../../classes/property.dart';
import '../../classes/request_body.dart';
import '../../helpers/converters.dart';
import '../../helpers/dart_type.dart';
import '../../helpers/utils.dart';
import 'class_serializer_generator.dart';

/// Generates Dart classes (Models or Entities) from Swagger API definitions.
///
/// This generator is responsible for:
/// - Creating model or entity classes based on Swagger paths.
/// - Handling request parameters, request bodies, and references.
/// - Writing generated classes into appropriate file paths.
/// - Generating referenced schemas and nested references.
class ClassGenerator {
  /// List of modules where generated classes will be placed.
  final List<String> moduleList;

  /// Swagger components (schemas, responses, etc.).
  final Components components;

  /// Flag to indicate whether to generate entity (`Param`) classes or model (`Model`) classes.
  final bool isForEntities;

  /// Root path where generated files will be stored.
  final String mainPath;

  /// Creates an instance of [ClassGenerator].
  ClassGenerator({
    required this.moduleList,
    required this.components,
    required this.isForEntities,
    required this.mainPath,
  });

  /// Generates a Dart class for the given API path.
  ///
  /// - [key] is the API endpoint.
  /// - [path] contains HTTP method information.
  void generateClass(String key, Map<String, HttpMethodInfo> path) {
    String endPoint = isForEntities ? 'Param' : 'Model';
    String routeName = getRouteName(key);
    String className = '$routeName$endPoint';

    String moduleName = getCategory(key);
    String filePath = getModelAndEntityFilePath(
      moduleName,
      routeName,
      isForEntities,
      mainPath,
    );
    List<String> contents = [];
    Set<String> refSchemas = {};
    StringBuffer classBuffer = StringBuffer();

    // Generate content for each HTTP method
    for (var httpMethodInfo in path.values) {
      String classContent = _generateClassContent(
        className: className,
        parameters: httpMethodInfo.parameters,
        requestBody: httpMethodInfo.requestBody,
        classBuffer: classBuffer,
      );
      contents.add(classContent);

      // Collect referenced schemas
      refSchemas = _collectRefSchemas(httpMethodInfo.parameters, refSchemas);
      refSchemas = _collectRefSchemas(
          httpMethodInfo.requestBody?.content?.values.toList(), refSchemas);

      // Special handling for multipart/form-data
      if (httpMethodInfo.requestBody?.content != null) {
        for (var contentType in httpMethodInfo.requestBody!.content!.keys) {
          if (contentType == "multipart/form-data" &&
              httpMethodInfo.requestBody!.content![contentType]?.schema
                  is ObjectProperty) {
            ObjectProperty schema = httpMethodInfo
                .requestBody!.content![contentType]!.schema as ObjectProperty;
            if (schema.properties != null) {
              for (var prop in schema.properties!.values) {
                // Handle array references
                if (prop is ArrayProperty && prop.items?.ref != null) {
                  refSchemas.add(prop.items!.ref!);
                }
                // Handle direct references
                if (prop.ref != null) {
                  refSchemas.add(prop.ref!);
                }
              }
            }
          }
        }
      }
    }

    // Write class content to file
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    for (var content in contents) {
      file.writeAsStringSync(content);
    }

    // Generate referenced types
    for (var refSchema in refSchemas) {
      String refClassName = _getRefClassName(refSchema);
      String refFilePath = getModelAndEntityFilePath(
        moduleName,
        refClassName,
        isForEntities,
        mainPath,
      );
      String refContent = _generateRefClass(refSchema, refClassName);

      if (refContent.isNotEmpty) {
        File(refFilePath).writeAsStringSync(refContent);

        // Generate nested references recursively
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
            String nestedRefFilePath = getModelAndEntityFilePath(
              moduleName,
              nestedRefClassName,
              isForEntities,
              mainPath,
            );
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

  /// Extracts a class name from a reference schema string.
  String _getRefClassName(String refSchema) {
    final ref = refSchema.split('/').last.split('.');
    String name =
        ref.last.toLowerCase() == "request" ? ref[ref.length - 2] : ref.last;

    if (refSchema.contains('.Shared.')) {
      return name;
    }
    String endPoint = isForEntities ? 'Param' : 'Model';
    return name + endPoint;
  }

  /// Generates a class for a referenced schema.
  String _generateRefClass(String refSchema, String className) {
    StringBuffer buffer = StringBuffer();

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
        value = convertToCamelCase(value);
        if (value == "new") {
          value = "neww"; // avoid Dart keyword conflict
        }
        buffer.writeln('  $value,');
      }
      buffer.writeln('}');
      return buffer.toString();
    }

    List<String> properties = [];
    bool withImport = false;

    // Handle object schemas
    if (schema is ObjectProperty && schema.properties != null) {
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        TProperty prop = entry.value;
        DartTypeInfo dartType = getDartType(prop, components, isForEntities);

        // Add imports for references
        if (dartType.isRef && prop.ref != null) {
          String refClassName = _getRefClassName(prop.ref!);
          String fileName = convertToSnakeCase(refClassName);
          buffer.writeln(
              'import \'$fileName${isForEntities ? '_param' : '_model'}.dart\';');
          withImport = true;
        }

        String propType = dartType.className;

        // Handle array types
        if (prop is ArrayProperty) {
          if (prop.items?.ref != null) {
            String itemRefClassName = _getRefClassName(prop.items!.ref!);
            String fileName = convertToSnakeCase(itemRefClassName);
            buffer.writeln(
                'import \'$fileName${isForEntities ? '_param' : '_model'}.dart\';');
            propType = 'List<$itemRefClassName>';
            withImport = true;
          } else if (prop.items is PrimitiveProperty &&
              (prop.items as PrimitiveProperty).type == 'string' &&
              (prop.items as PrimitiveProperty).format == 'binary') {
            propType = 'List<String>';
          } else {
            propType =
                'List<${getDartType(prop.items, components, isForEntities).className}>';
          }
        }

        String nullableSuffix = prop.nullable == true ? '?' : '';
        properties.add('  final $propType$nullableSuffix $propName;');
      }
    }

    if (withImport) {
      buffer.writeln();
    }

    // Generate class definition
    buffer.writeln('class $className {');
    for (final prop in properties) {
      buffer.writeln(prop);
    }
    buffer.writeln();

    // Constructor and serialization
    if (schema is ObjectProperty && schema.properties != null) {
      buffer.writeln('  $className({');
      for (var entry in schema.properties!.entries) {
        buffer.writeln('    required this.${entry.key},');
      }
      buffer.writeln('  });');

      if (isForEntities) {
        buffer.writeln('''
  Map<String, dynamic> toJson() {
    return {''');
        for (var entry in schema.properties!.entries) {
          buffer.writeln('      \'${entry.key}\': ${entry.key},');
        }
        buffer.writeln('''
    };
  }''');
      } else {
        buffer.writeln('''
  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(''');
        for (var entry in schema.properties!.entries) {
          String camelCaseFieldName =
              convertToCamelCase(entry.key.replaceAll('.', ''));
          buffer.writeln('      $camelCaseFieldName: json["${entry.key}"],');
        }
        buffer.writeln('''
    );
  }''');
      }
    }
    buffer.writeln('}');
    return buffer.toString();
  }

  /// Collects reference schemas from parameters.
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

  /// Collects nested reference schemas from an [ObjectProperty].
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

  /// Generates the class content for parameters and request body.
  String _generateClassContent({
    required String className,
    required List<IParameter>? parameters,
    required TRequestBody? requestBody,
    required StringBuffer classBuffer,
  }) {
    List<String> parameterDeclarations = [];
    List<String> requiredParams = [];

    // Handle parameters
    if (parameters != null) {
      for (var param in parameters) {
        String paramName = param.name;
        if (paramName == 'X-TimeZoneId' ||
            paramName == 'tz-offset' ||
            paramName == 'lang' ||
            paramName == 'DebugMode') {
          continue;
        }
        DartTypeInfo dartTypeInfo =
            getDartType(param.schema, components, isForEntities);

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
            '  final $paramType ${convertToCamelCase(paramName).replaceAll("/", "")};');
        requiredParams.add(
            'required this.${convertToCamelCase(paramName).replaceAll("/", "")}');
      }
    }

    bool withImport = false;

    // Handle request body
    if (requestBody?.content != null) {
      for (var prop in requestBody!.content!.keys) {
        bool isRef = false;

        if (prop == "application/json" || prop == "multipart/form-data") {
          if (requestBody.content![prop]?.schema == null) {
            continue;
          }
          if (requestBody.content![prop]?.schema?.ref != null) {
            isRef = true;
          }
        } else if (requestBody.content![prop]?.schema == null ||
            prop.contains("/")) {
          continue;
        }

        // Handle multipart/form-data object schema
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
                  withImport = true;
                  fieldType = 'List<$itemRefClassName>';
                } else if (fieldSchema.items is PrimitiveProperty &&
                    (fieldSchema.items as PrimitiveProperty).type == 'string' &&
                    (fieldSchema.items as PrimitiveProperty).format ==
                        'binary') {
                  fieldType = 'List<String>';
                } else {
                  fieldType =
                      'List<${getDartType(fieldSchema.items, components, isForEntities).className}>';
                }
              } else {
                DartTypeInfo fieldTypeInfo =
                    getDartType(fieldSchema, components, isForEntities);
                fieldType = fieldTypeInfo.className;

                if (fieldSchema.ref != null) {
                  String refClassName = _getRefClassName(fieldSchema.ref!);
                  classBuffer.writeln(
                      'import \'${convertToSnakeCase(refClassName)}${isForEntities ? '_param' : '_model'}.dart\';');
                  withImport = true;
                  fieldType = refClassName;
                }
              }

              String nullableSuffix = fieldSchema.nullable == true ? '?' : '';
              String camelCaseFieldName =
                  convertToCamelCase(fieldName.replaceAll('.', ''));
              parameterDeclarations.add(
                  '  final $fieldType$nullableSuffix ${camelCaseFieldName.replaceAll("/", "")};');
              requiredParams.add(
                  'required this.${camelCaseFieldName.replaceAll("/", "")}');
            }
          }
        } else {
          DartTypeInfo dartTypeInfo = getDartType(
              requestBody.content![prop]?.schema, components, isForEntities);
          if (dartTypeInfo.isRef) {
            String refClassName =
                _getRefClassName(requestBody.content![prop]!.schema!.ref!);
            classBuffer.writeln(
                'import \'${convertToSnakeCase(refClassName)}${isForEntities ? '_param' : '_model'}.dart\';');
            withImport = true;
          }

          String propType = dartTypeInfo.className;
          String propName = prop;

          if (prop.contains(".")) {
            propName = prop.replaceAll('.', '');
          }

          parameterDeclarations.add(
              '  final $propType ${convertToCamelCase(isRef ? propType : propName).replaceAll("/", "")};');
          requiredParams.add(
              'required this.${convertToCamelCase(isRef ? propType : propName).replaceAll("/", "")}');
        }
      }
    }

    if (withImport) {
      classBuffer.writeln();
    }

    // Generate class definition
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

    if (isForEntities) {
      classSerializerGenerator.genereateToJson(parameters, requestBody);
    } else {
      classSerializerGenerator.generateFromJson(parameters, requestBody);
    }
    return classBuffer.toString();
  }
}
