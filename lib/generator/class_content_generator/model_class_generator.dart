import 'dart:io';

import '../../classes/components.dart';
import '../../classes/http_method_info.dart';
import '../../classes/property.dart';
import '../../helpers/converters.dart';
import '../../helpers/dart_type.dart';
import '../../helpers/utils.dart';

/// Generates Dart model classes from Swagger schemas.
///
/// - Creates a main response model per endpoint.
/// - Traverses all referenced schemas recursively.
/// - Handles enums, arrays, nested objects, and multipart/form-data.
/// - Writes each class to its own `*_model.dart` file.
class ModelClassGenerator {
  final List<String> moduleList;
  final Components components;
  final String mainPath;

  ModelClassGenerator({
    required this.moduleList,
    required this.components,
    required this.mainPath,
  });

  /// Generates a model class for the given [key] (API path).
  ///
  /// Steps:
  /// 1. Determine route and class name.
  /// 2. Collect referenced schemas from:
  ///    - response bodies,
  ///    - parameters,
  ///    - request bodies (including multipart).
  /// 3. Generate the main model class.
  /// 4. Generate referenced schemas recursively.
  void generateClass(String key, Map<String, HttpMethodInfo> path) {
    String endPoint = 'Model';
    String routeName = getRouteName(key);
    String className = '$routeName$endPoint';

    String moduleName = getCategory(key);
    String filePath =
        getModelAndEntityFilePath(moduleName, routeName, false, mainPath);
    Set<String> refSchemas = {};

    // Collect referenced schemas from responses, params, and request body
    for (var httpMethodInfo in path.values) {
      // Response schema
      final response200 = httpMethodInfo.responses.response200;
      final responseContent = response200?.content;
      final responseSchema = responseContent != null
          ? responseContent['application/json']?.schema
          : null;

      if (responseSchema != null && responseSchema.ref != null) {
        refSchemas.add(responseSchema.ref!);
      }

      // Parameters
      refSchemas = _collectRefSchemas(httpMethodInfo.parameters, refSchemas);

      // Request body
      refSchemas = _collectRefSchemas(
        httpMethodInfo.requestBody?.content?.values.toList(),
        refSchemas,
      );

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
                if (prop is ArrayProperty && prop.items?.ref != null) {
                  refSchemas.add(prop.items!.ref!);
                }
                if (prop.ref != null) {
                  refSchemas.add(prop.ref!);
                }
              }
            }
          }
        }
      }
    }

    // Also include schemas from components that match this module
    for (var schemaName in components.schemas.keys) {
      if (schemaName.toLowerCase().contains(moduleName.toLowerCase()) ||
          schemaName.toLowerCase().contains('package')) {
        refSchemas.add('#/components/schemas/$schemaName');
      }
    }

    final file = File(filePath);
    file.parent.createSync(recursive: true);

    // Generate main endpoint model
    StringBuffer mainClassBuffer = StringBuffer();
    mainClassBuffer.writeln('// Generated model for $routeName');
    mainClassBuffer.writeln();
    mainClassBuffer.writeln('class $className {');
    mainClassBuffer.writeln('  final Map<String, dynamic> data;');
    mainClassBuffer.writeln();
    mainClassBuffer.writeln('  $className({required this.data});');
    mainClassBuffer.writeln();
    mainClassBuffer
        .writeln('  factory $className.fromJson(Map<String, dynamic> json) {');
    mainClassBuffer.writeln('    return $className(data: json);');
    mainClassBuffer.writeln('  }');
    mainClassBuffer.writeln('}');

    file.writeAsStringSync(mainClassBuffer.toString());

    // Generate referenced schema models
    for (var refSchema in refSchemas) {
      String refClassName = _getRefClassName(refSchema);
      String refFilePath =
          getModelAndEntityFilePath(moduleName, refClassName, false, mainPath);
      String refContent = _generateRefClass(refSchema, refClassName);
      if (refContent.isNotEmpty) {
        File(refFilePath).writeAsStringSync(refContent);

        _generateNestedReferences(refSchema, moduleName, mainPath);
      }
    }
  }

  /// Recursively generates models for nested references inside [refSchema].
  void _generateNestedReferences(
      String refSchema, String moduleName, String mainPath) {
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
          false,
          mainPath,
        );

        if (!File(nestedRefFilePath).existsSync()) {
          String nestedRefContent =
              _generateRefClass(nestedRef, nestedRefClassName);
          if (nestedRefContent.isNotEmpty) {
            File(nestedRefFilePath).writeAsStringSync(nestedRefContent);
            _generateNestedReferences(nestedRef, moduleName, mainPath);
          }
        }
      }
    }
  }

  /// Resolves a schema reference to a Dart class name.
  ///
  /// - Appends `Model` suffix for most cases.
  /// - Handles `Enums` → enum class.
  /// - Handles generic schemas with backticks.
  String _getRefClassName(String refSchema) {
    final ref = refSchema.split('/').last.split('.');

    if (refSchema.contains('`')) {
      final genericMatch = RegExp(r'\[\[([^,]+),.*\]\]').firstMatch(refSchema);
      if (genericMatch != null) {
        final innerType = genericMatch.group(1)!.split('.').last;
        return '${innerType}Model';
      }
    }

    String name = ref.last.toString().toLowerCase() == "request"
        ? ref[ref.length - 2]
        : ref.last;

    if (refSchema.contains('.Shared.')) {
      return name;
    }
    if (refSchema.contains('.Enums.')) {
      return name;
    }

    String endPoint = 'Model';
    return name + endPoint;
  }

  /// Generates a Dart class or enum for a given schema reference.
  ///
  /// - Falls back to a placeholder class if schema is missing.
  /// - Handles enums (string type with `enumValues`).
  /// - Handles object schemas with nested properties.
  String _generateRefClass(String refSchema, String className) {
    StringBuffer buffer = StringBuffer();

    final schema = components.schemas[refSchema.split('/').last];
    if (schema == null) {
      // Unknown schema → generate placeholder
      if (refSchema.contains('.Enums.')) {
        buffer.writeln('enum $className {');
        buffer.writeln(
            '  // TODO: Define enum values based on API documentation');
        buffer.writeln('  placeholder,');
        buffer.writeln('}');
        return buffer.toString();
      } else {
        buffer.writeln('class $className {');
        buffer
            .writeln('  // TODO: Define properties based on API documentation');
        buffer.writeln('  final String? placeholder;');
        buffer.writeln();
        buffer.writeln('  $className({this.placeholder});');
        buffer.writeln();
        buffer.writeln(
            '  factory $className.fromJson(Map<String, dynamic> json) {');
        buffer.writeln('    return $className(');
        buffer.writeln('      placeholder: json["placeholder"],');
        buffer.writeln('    );');
        buffer.writeln('  }');
        buffer.writeln('}');
        return buffer.toString();
      }
    }

    // Handle primitive enum type
    if (schema is PrimitiveProperty &&
        schema.type == 'string' &&
        schema.enumValues != null) {
      buffer.writeln('enum $className {');
      for (var value in schema.enumValues!) {
        value = convertToCamelCase(value);
        if (value == "new") {
          value = "neww";
        }
        buffer.writeln('  $value,');
      }
      buffer.writeln('}');
      return buffer.toString();
    }

    // Otherwise, treat as object
    List<String> properties = [];
    List<String> constructorParams = [];
    List<String> fromJsonParams = [];
    Set<String> enumImports = {};

    if (schema is ObjectProperty && schema.properties != null) {
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        TProperty prop = entry.value;

        DartTypeInfo dartType = getDartType(prop, components, false);

        // Detect enums referenced via $ref
        bool isEnum = false;
        if (prop.ref != null) {
          final refSchemaName = prop.ref!.split('/').last;
          final refSchemaObj = components.schemas[refSchemaName];
          if (refSchemaObj is PrimitiveProperty &&
              refSchemaObj.enumValues != null) {
            isEnum = true;
            String enumImportFile =
                '${convertToSnakeCase(_getRefClassName(prop.ref!))}.dart';
            enumImports.add(enumImportFile);
          }
        }

        // Import nested reference classes
        if (dartType.isRef && prop.ref != null && !isEnum) {
          String refClassName = _getRefClassName(prop.ref!);
          String fileName = convertToSnakeCase(refClassName);
          buffer.writeln('import \'${fileName}_model.dart\';');
        }

        // Property type resolution
        String propType = dartType.className;
        if (isEnum) {
          propType = _getRefClassName(prop.ref!);
        }
        if (prop is ArrayProperty) {
          if (prop.items?.ref != null) {
            final itemRefSchemaName = prop.items!.ref!.split('/').last;
            final itemRefSchemaObj = components.schemas[itemRefSchemaName];
            if (itemRefSchemaObj is PrimitiveProperty &&
                itemRefSchemaObj.enumValues != null) {
              String itemRefClassName = _getRefClassName(prop.items!.ref!);
              propType = 'List<$itemRefClassName>';
              String enumImportFile =
                  '${convertToSnakeCase(itemRefClassName)}_model.dart';
              enumImports.add(enumImportFile);
            } else {
              String itemRefClassName = _getRefClassName(prop.items!.ref!);
              String fileName = convertToSnakeCase(itemRefClassName);
              buffer.writeln('import \'${fileName}_model.dart\';');
              propType = 'List<$itemRefClassName>';
            }
          } else if (prop.items is PrimitiveProperty &&
              (prop.items as PrimitiveProperty).type == 'string' &&
              (prop.items as PrimitiveProperty).format == 'binary') {
            propType = 'List<String>';
          } else {
            propType =
                'List<${getDartType(prop.items, components, false).className}>';
          }
        }

        String nullableSuffix = prop.nullable == true ? '?' : '';
        String camelCaseFieldName = convertToCamelCase(
          propName.replaceAll('.', '').replaceAll("/", ""),
        );

        // Add property
        properties.add('  final $propType$nullableSuffix $camelCaseFieldName;');

        // Constructor param
        if (prop.nullable == true) {
          constructorParams.add('    this.$camelCaseFieldName,');
        } else {
          constructorParams.add('    required this.$camelCaseFieldName,');
        }

        // JSON parsing logic
        String fromJsonParam;
        if (prop is ArrayProperty && prop.items?.ref != null) {
          final itemRefSchemaName = prop.items!.ref!.split('/').last;
          final itemRefSchemaObj = components.schemas[itemRefSchemaName];
          if (itemRefSchemaObj is PrimitiveProperty &&
              itemRefSchemaObj.enumValues != null) {
            String itemRefClassName = _getRefClassName(prop.items!.ref!);
            String fallbackValue = itemRefSchemaObj.enumValues!.isNotEmpty
                ? convertToCamelCase(itemRefSchemaObj.enumValues!.first)
                : 'placeholder';
            fromJsonParam =
                '      $camelCaseFieldName: (json["$propName"] as List<dynamic>?)?.map((e) => $itemRefClassName.values.firstWhere((c) => c.toString() == \'$itemRefClassName.\$e\', orElse: () => $itemRefClassName.$fallbackValue)).toList() ?? [],';
          } else {
            String itemRefClassName = _getRefClassName(prop.items!.ref!);
            fromJsonParam =
                '      $camelCaseFieldName: (json["$propName"] as List<dynamic>?)?.map((e) => $itemRefClassName.fromJson(e as Map<String, dynamic>)).toList() ?? [],';
          }
        } else if (isEnum) {
          String enumClassName = _getRefClassName(prop.ref!);
          final refSchemaName = prop.ref!.split('/').last;
          final refSchemaObj = components.schemas[refSchemaName];
          String fallbackValue = 'placeholder';
          if (refSchemaObj is PrimitiveProperty &&
              refSchemaObj.enumValues != null &&
              refSchemaObj.enumValues!.isNotEmpty) {
            fallbackValue = convertToCamelCase(refSchemaObj.enumValues!.first);
          }
          if (prop.nullable == true) {
            fromJsonParam =
                '      $camelCaseFieldName: json["$propName"] != null ? $enumClassName.values.firstWhere((e) => e.toString() == \'$enumClassName.\${json["$propName"]}\', orElse: () => $enumClassName.$fallbackValue) : null,';
          } else {
            fromJsonParam =
                '      $camelCaseFieldName: $enumClassName.values.firstWhere((e) => e.toString() == \'$enumClassName.\${json["$propName"]}\', orElse: () => $enumClassName.$fallbackValue),';
          }
        } else if (dartType.isRef && prop.ref != null) {
          String refClassName = _getRefClassName(prop.ref!);
          fromJsonParam =
              '      $camelCaseFieldName: json["$propName"] != null ? $refClassName.fromJson(json["$propName"] as Map<String, dynamic>) : null,';
        } else if (prop is ArrayProperty) {
          String itemType =
              getDartType(prop.items, components, false).className;
          fromJsonParam =
              '      $camelCaseFieldName: (json["$propName"] as List<dynamic>?)?.cast<$itemType>() ?? [],';
        } else {
          fromJsonParam = '      $camelCaseFieldName: json["$propName"],';
        }
        fromJsonParams.add(fromJsonParam);
      }
    }

    // Add enum imports
    for (final enumImport in enumImports) {
      buffer.writeln('import \'$enumImport\';');
    }

    // Generate class
    buffer.writeln('class $className {');
    for (final prop in properties) {
      buffer.writeln(prop);
    }
    buffer.writeln();

    if (schema is ObjectProperty && schema.properties != null) {
      buffer.writeln('  $className({');
      for (final param in constructorParams) {
        buffer.writeln(param);
      }
      buffer.writeln('  });');

      buffer.writeln(
        '''
  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(''',
      );
      for (final param in fromJsonParams) {
        buffer.writeln(param);
      }
      buffer.writeln('''
    );
  }''');
    }

    buffer.writeln('}');
    return buffer.toString();
  }

  /// Collects `$ref` schemas from parameters or request body content.
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

  /// Traverses object properties recursively to collect nested `$ref` schemas.
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
}
