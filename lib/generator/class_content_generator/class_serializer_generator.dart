import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

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
  void generateConstructure(List<String> params) {
    if (params.isNotEmpty) {
      classBuffer.writeln("");
      classBuffer.writeln('  $className({');
      for (var element in params) {
        classBuffer.writeln('    $element,');
      }
      classBuffer.writeln('  });');
      classBuffer.writeln("");
    }
  }

  /// Generates a `toJson` method for serializing the class to a map.
  ///
  /// Handles:
  /// - Parameters (skipping ignored ones like `X-TimeZoneId`, `tz-offset`, `lang`, `DebugMode`)
  /// - Request bodies, including `application/json` and `multipart/form-data`
  /// - References to other schemas
  void genereateToJson(List<GeneratedJsonLine> lines, bool isMultiPart) {
    classBuffer.writeln(
      '''
  ${isMultiPart ? "FormData" : "Map<String, dynamic>"} toJson() {
    return ${isMultiPart ? "FormData.fromMap(" : ""}{''',
    );
    bool containsNull = false;
    for (var line in lines) {
      classBuffer.writeln(line.generatedJsonLine);
      containsNull = containsNull || line.nullable;
    }
    String removeNullValues = (isMultiPart || containsNull)
        ? "..removeWhere((key, value) => value == null)"
        : "";
    classBuffer.writeln('''
    }$removeNullValues${isMultiPart ? ")" : ""};
  }''');
    classBuffer.writeln('}');
  }

  void generateEnums(List<String> enums) {
    for (final element in enums) {
      classBuffer.writeln(element);
    }
  }

  void generateImports(
      List<GeneratedParameters> generateParametars, bool isMultiPart) {
    bool addEmptyLine = false;
    if (generateParametars.any((element) {
      return element.type.contains("File");
    })) {
      classBuffer.writeln("import 'dart:io';");
      addEmptyLine = true;
    }
    if (isMultiPart) {
      classBuffer.writeln("import 'package:dio/dio.dart';");
      addEmptyLine = true;
    }
    if (addEmptyLine) {
      classBuffer.writeln("");
    }
  }

  /// Generates a `fromJson` factory constructor for deserializing a class
  /// from a JSON map.
  ///
  /// Handles:
  /// - Parameters (skipping ignored ones)
  /// - Request body with `application/json` and `multipart/form-data`
  /// - Referenced schemas
//   void generateFromJson(
//     List<Parameter>? parameters,
//     RequestBody? requestBody,
//   ) {
//     bool isWritingStarted = false;

//     // Deserialize parameters
//     if (parameters != null) {
//       for (var param in parameters) {
//         String paramName = param.name;
//         if (param.inn == "header") {
//           continue;
//         }
//         String camelCaseName =
//             paramName.replaceAll('.', '').replaceAll('/', '').toCamelCase();
//         if (!isWritingStarted) {
//           classBuffer.writeln(
//             '''
//     factory $className.fromJson(Map<String, dynamic> json) {
//     return $className (''',
//           );
//           isWritingStarted = true;
//         }
//         classBuffer.writeln('      $camelCaseName: json["$paramName"] ,');
//       }
//     }

//     // Deserialize request body content
//     if (requestBody?.content != null) {
//       final contentType = requestBody!.content!.contentType;
//       bool isRef = false;

//       if (contentType == TContentType.applicationJson ||
//           contentType == TContentType.multipartFormData) {
//         if (requestBody.content?.schema == null) {
//           // continue;
//         }
//         if (requestBody.content?.schema?.ref != null) {
//           isRef = true;
//         }
//       } else if (requestBody.content?.schema == null ||
//           contentType.value.contains("/")) {
//         // continue;
//       }

//       // Handle multipart/form-data with object schema
//       if (contentType == TContentType.multipartFormData &&
//           requestBody.content?.schema is ObjectProperty) {
//         ObjectProperty schema = requestBody.content!.schema as ObjectProperty;
//         if (schema.properties != null) {
//           if (!isWritingStarted) {
//             classBuffer.writeln(
//               '''
//     factory $className.fromJson(Map<String, dynamic> json) {
//     return $className(''',
//             );
//             isWritingStarted = true;
//           }

//           String fieldName = schema.properties?.propertyName ?? "";
//           String camelCaseFieldName =
//               fieldName.replaceAll('.', '').replaceAll('/', "").toCamelCase();
//           classBuffer
//               .writeln('      $camelCaseFieldName: json["$fieldName"] ,');
//         }
//       } else if (isRef) {
//         // Handle referenced schemas
//         DartTypeInfo dartTypeInfo =
//             getDartType(requestBody.content?.schema, components, false);
//         String propType = dartTypeInfo.className;

//         classBuffer.write('''
//   factory $className.fromJson(Map<String, dynamic> json) {
//     return $className(
//       ${(propType).toCamelCase()}: $propType.fromJson(json),
//     );
//   }
// }''');
//         return;
//       } else {
//         // Handle primitive request body properties
//         String camelCaseName = contentType.value
//             .replaceAll('.', '')
//             .replaceAll('/', '')
//             .toCamelCase();
//         if (!isWritingStarted) {
//           classBuffer.writeln('''
//   factory $className.fromJson(Map<String, dynamic> json) {
//     return $className(''');
//           isWritingStarted = true;
//         }
//         classBuffer.writeln('      $camelCaseName: json["$contentType"],');
//       }
//     }

//     // Close constructor if started
//     if (isWritingStarted) {
//       classBuffer.writeln('''
//     );
//   }''');
//     }

//     classBuffer.writeln('}');
//   }
}
