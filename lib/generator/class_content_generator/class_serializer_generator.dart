import '../../classes/components.dart';
import '../../classes/parameter.dart';
import '../../classes/request_body.dart';
import '../../helpers/converters.dart';
import '../../helpers/dart_type.dart';
import 'package:flutter_easy_swagger_generator/classes/property.dart';

/// Generates serialization logic (`toJson` and `fromJson`) for Dart classes
/// based on Swagger/OpenAPI specifications.
///
/// This includes handling:
/// - Parameters (query, header, path, etc.)
/// - Request body with different content types (`application/json`, `multipart/form-data`)
/// - References to reusable schemas
class ClassSerializerGenerator {
  /// Buffer where generated class code is written
  final StringBuffer classBuffer;

  /// Name of the class being generated
  final String className;

  /// Swagger/OpenAPI components used for resolving schemas and references
  final Components components;

  ClassSerializerGenerator({
    required this.classBuffer,
    required this.className,
    required this.components,
  });

  /// Generates the constructor for the target class.
  ///
  /// Ensures required parameters are included in the constructor signature.
  void generateConstructure(List<String> requiredParams) {
    if (requiredParams.isNotEmpty) {
      classBuffer.write('  $className({');
      classBuffer.write(requiredParams.join(', '));
      classBuffer.writeln('});');
    }
  }

  /// Generates a `toJson` method for serializing the class to a map.
  ///
  /// Handles:
  /// - Parameters (skipping ignored ones like `X-TimeZoneId`, `tz-offset`, `lang`, `DebugMode`)
  /// - Request bodies, including `application/json` and `multipart/form-data`
  /// - References to other schemas
  void genereateToJson(
    List<IParameter>? parameters,
    TRequestBody? requestBody,
  ) {
    bool isWritingStarted = false;

    // Serialize parameters
    if (parameters != null) {
      for (var param in parameters) {
        String paramName = param.name;
        if (paramName == 'X-TimeZoneId' ||
            paramName == 'tz-offset' ||
            paramName == 'lang' ||
            paramName == 'DebugMode') {
          continue;
        }
        String camelCaseName =
            convertToCamelCase(paramName.replaceAll('.', ''));
        if (!isWritingStarted) {
          classBuffer.writeln('''
  Map<String, dynamic> toJson() {
    return {''');
          isWritingStarted = true;
        }
        classBuffer.writeln('      \'$paramName\': $camelCaseName,');
      }
    }

    // Serialize request body content
    if (requestBody?.content != null) {
      for (var prop in requestBody!.content!.keys) {
        bool isRef = false;

        // Handle special content types
        if (prop == "application/json" || prop == "multipart/form-data") {
          if (requestBody.content![prop]?.schema == null) {
            continue;
          }

          // Detect references
          if (requestBody.content![prop]?.schema?.ref != null) {
            isRef = true;
          }
        } else if (requestBody.content![prop]?.schema == null ||
            prop.contains("/")) {
          continue;
        }

        // Handle multipart/form-data with object schema
        if (prop == "multipart/form-data" &&
            requestBody.content![prop]?.schema is ObjectProperty) {
          ObjectProperty schema =
              requestBody.content![prop]!.schema as ObjectProperty;
          if (schema.properties != null) {
            if (!isWritingStarted) {
              classBuffer.writeln('''
  Map<String, dynamic> toJson() {
    return {''');
              isWritingStarted = true;
            }

            for (var entry in schema.properties!.entries) {
              String fieldName = entry.key;
              String camelCaseFieldName = convertToCamelCase(
                  fieldName.replaceAll('.', '')..replaceAll('/', ""));
              classBuffer.writeln('      \'$fieldName\': $camelCaseFieldName,');
            }
          }
        } else if (isRef) {
          // Handle referenced schemas
          DartTypeInfo dartTypeInfo =
              getDartType(requestBody.content![prop]?.schema, components, true);
          String propType = dartTypeInfo.className;

          classBuffer.write('''
  Map<String, dynamic> toJson() {
    return ${convertToCamelCase(propType)}.toJson();
  }    
}''');
          return;
        } else {
          // Handle primitive request body properties
          String camelCaseName =
              convertToCamelCase(prop.replaceAll('.', '').replaceAll('/', ''));
          if (!isWritingStarted) {
            classBuffer.writeln('''
  Map<String, dynamic> toJson() {
    return {
''');
            isWritingStarted = true;
          }
          classBuffer.writeln('      \'$prop\': $camelCaseName,');
        }
      }
    }

    // Close map if started
    if (isWritingStarted) {
      classBuffer.writeln('''
    };
  }''');
    }

    classBuffer.writeln('}');
  }

  /// Generates a `fromJson` factory constructor for deserializing a class
  /// from a JSON map.
  ///
  /// Handles:
  /// - Parameters (skipping ignored ones)
  /// - Request body with `application/json` and `multipart/form-data`
  /// - Referenced schemas
  void generateFromJson(
    List<IParameter>? parameters,
    TRequestBody? requestBody,
  ) {
    bool isWritingStarted = false;

    // Deserialize parameters
    if (parameters != null) {
      for (var param in parameters) {
        String paramName = param.name;
        if (paramName == 'X-TimeZoneId' ||
            paramName == 'tz-offset' ||
            paramName == 'lang' ||
            paramName == 'DebugMode') {
          continue;
        }
        String camelCaseName =
            convertToCamelCase(paramName.replaceAll('.', ''));
        if (!isWritingStarted) {
          classBuffer.writeln(
            '''
    factory $className.fromJson(Map<String, dynamic> json) {
    return $className (''',
          );
          isWritingStarted = true;
        }
        classBuffer.writeln('      $camelCaseName: json["$paramName"] ,');
      }
    }

    // Deserialize request body content
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

        // Handle multipart/form-data with object schema
        if (prop == "multipart/form-data" &&
            requestBody.content![prop]?.schema is ObjectProperty) {
          ObjectProperty schema =
              requestBody.content![prop]!.schema as ObjectProperty;
          if (schema.properties != null) {
            if (!isWritingStarted) {
              classBuffer.writeln(
                '''
    factory $className.fromJson(Map<String, dynamic> json) {
    return $className(''',
              );
              isWritingStarted = true;
            }

            for (var entry in schema.properties!.entries) {
              String fieldName = entry.key;
              String camelCaseFieldName = convertToCamelCase(
                  fieldName.replaceAll('.', '')..replaceAll('/', ""));
              classBuffer
                  .writeln('      $camelCaseFieldName: json["$fieldName"] ,');
            }
          }
        } else if (isRef) {
          // Handle referenced schemas
          DartTypeInfo dartTypeInfo = getDartType(
              requestBody.content![prop]?.schema, components, false);
          String propType = dartTypeInfo.className;

          classBuffer.write('''
  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(
      ${convertToCamelCase(propType)}: $propType.fromJson(json),
    );
  }    
}''');
          return;
        } else {
          // Handle primitive request body properties
          String camelCaseName =
              convertToCamelCase(prop.replaceAll('.', '').replaceAll('/', ''));
          if (!isWritingStarted) {
            classBuffer.writeln('''
  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(''');
            isWritingStarted = true;
          }
          classBuffer.writeln('      $camelCaseName: json["$prop"],');
        }
      }
    }

    // Close constructor if started
    if (isWritingStarted) {
      classBuffer.writeln('''
    );
  }''');
    }

    classBuffer.writeln('}');
  }
}
