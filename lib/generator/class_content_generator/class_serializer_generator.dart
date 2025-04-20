import '../../classes/components.dart';
import '../../classes/parameter.dart';
import '../../classes/request_body.dart';
import '../../helpers/converters.dart';
import '../../helpers/dart_type.dart';
import 'package:flutter_easy_swagger_generator/classes/property.dart';

class ClassSerializerGenerator {
  final StringBuffer classBuffer;
  final String className;
  final Components components;

  ClassSerializerGenerator({
    required this.classBuffer,
    required this.className,
    required this.components,
  });

  generateConstructure(List<String> requiredParams) {
    if (requiredParams.isNotEmpty) {
      classBuffer.write('  $className({');
      classBuffer.write(requiredParams.join(', '));
      classBuffer.writeln('});');
    }
  }

  genereateToJson(
    List<IParameter>? parameters,
    TRequestBody? requestBody,
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
    if (isWritingStarted) {
      classBuffer.writeln('''
    };
  }''');
    }

    classBuffer.writeln('}');
  }

  generateFromJson(
    List<IParameter>? parameters,
    TRequestBody? requestBody,
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
    if (isWritingStarted) {
      classBuffer.writeln('''
    );
  }''');
    }

    classBuffer.writeln('}');
  }
}
