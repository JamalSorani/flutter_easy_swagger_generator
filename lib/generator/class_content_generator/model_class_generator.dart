import 'dart:io';

import '../../classes/components.dart';
import '../../classes/http_method_info.dart';
import '../../classes/property.dart';
import '../../helpers/converters.dart';
import '../../helpers/dart_type.dart';
import '../../helpers/utils.dart';

class ModelClassGenerator {
  final List<String> moduleList;
  final Components components;
  final String mainPath;

  ModelClassGenerator(
      {required this.moduleList,
      required this.components,
      required this.mainPath});

  void generateClass(String key, Map<String, HttpMethodInfo> path) {
    String endPoint = 'Model';
    String routeName = getRouteName(key);
    String className = '$routeName$endPoint';

    String moduleName = getCategory(key);
    String filePath =
        getModelAndEntityFilePath(moduleName, routeName, false, mainPath);
    List<String> contents = [];
    Set<String> refSchemas = {};
    StringBuffer classBuffer = StringBuffer();

    for (var httpMethodInfo in path.values) {
      // Extract the response schema (assuming 200 OK and application/json)
      final response200 = httpMethodInfo.responses.response200;
      final responseContent = response200?.content;
      final responseSchema = responseContent != null
          ? responseContent['application/json']?.schema
          : null;

      if (responseSchema != null) {
        String classContent = _generateResponseModelClass(
          className: className,
          schema: responseSchema,
          classBuffer: classBuffer,
        );
        contents.add(classContent);
        // Collect referenced schemas, etc. as needed
        // (You may want to implement _collectRefSchemas for response schemas as well)
      }

      refSchemas = _collectRefSchemas(httpMethodInfo.parameters, refSchemas);
      refSchemas = _collectRefSchemas(
          httpMethodInfo.requestBody?.content?.values.toList(), refSchemas);

      // Special handling for specific types
      if (httpMethodInfo.requestBody?.content != null) {
        for (var contentType in httpMethodInfo.requestBody!.content!.keys) {
          if (contentType == "multipart/form-data" &&
              httpMethodInfo.requestBody!.content![contentType]?.schema
                  is ObjectProperty) {
            ObjectProperty schema = httpMethodInfo
                .requestBody!.content![contentType]!.schema as ObjectProperty;
            if (schema.properties != null) {
              for (var prop in schema.properties!.values) {
                // Handle array properties with references
                if (prop is ArrayProperty && prop.items?.ref != null) {
                  if (prop.items!.ref != null) {
                    refSchemas.add(prop.items!.ref!);
                  }
                }

                // Handle direct references
                if (prop.ref != null) {
                  refSchemas.add(prop.ref!);
                }

                // Special check for WholesalePriceType
                if (prop.ref != null) {
                  refSchemas.add(prop.ref!);
                }
              }
            }
          }
        }
      }
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
          getModelAndEntityFilePath(moduleName, refClassName, false, mainPath);
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
            String nestedRefFilePath = getModelAndEntityFilePath(
                moduleName, nestedRefClassName, false, mainPath);
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
    String endPoint = 'Model';
    return name + endPoint;
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
        value = convertToCamelCase(value);
        if (value == "new") {
          value = "neww";
        }
        buffer.writeln('  $value,');
      }
      buffer.writeln('}');
      return buffer.toString();
    }

    List<String> properties = [];
    bool withImport = false;
    if (schema is ObjectProperty && schema.properties != null) {
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        TProperty prop = entry.value;

        DartTypeInfo dartType = getDartType(prop, components, false);

        if (dartType.isRef && prop.ref != null) {
          String refClassName = _getRefClassName(prop.ref!);
          String fileName = convertToSnakeCase(refClassName);
          buffer.writeln('import \'$fileName${'_model'}.dart\';');
          withImport = true;
        }

        String propType = dartType.className;
        if (prop is ArrayProperty) {
          if (prop.items?.ref != null) {
            String itemRefClassName = _getRefClassName(prop.items!.ref!);
            String fileName = convertToSnakeCase(itemRefClassName);
            buffer.writeln('import \'$fileName${'_model'}.dart\';');
            propType = 'List<$itemRefClassName>';
            withImport = true;
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
            propName.replaceAll('.', '').replaceAll("/", ""));
        properties.add('  final $propType$nullableSuffix $camelCaseFieldName;');
      }
    }
    if (withImport) {
      buffer.writeln();
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
        String camelCaseFieldName = convertToCamelCase(
            propName.replaceAll('.', '').replaceAll("/", ""));
        buffer.writeln('    required this.$camelCaseFieldName,');
      }
      buffer.writeln('  });');

      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        String camelCaseFieldName =
            convertToCamelCase(propName.replaceAll('.', ''));
        buffer.writeln('      \'$propName\': $camelCaseFieldName,');
      }

      buffer.writeln(
        '''
  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(''',
      );
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        String camelCaseFieldName =
            convertToCamelCase(propName.replaceAll('.', ''));
        buffer.writeln('      $camelCaseFieldName: json["$propName"],');
      }
      buffer.writeln('''
    );
  }''');
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

  String _generateResponseModelClass({
    required String className,
    required TProperty schema,
    required StringBuffer classBuffer,
  }) {
    // This is similar to _generateRefClass, but for a direct schema
    List<String> properties = [];
    bool withImport = false;
    if (schema is ObjectProperty && schema.properties != null) {
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        TProperty prop = entry.value;
        DartTypeInfo dartType = getDartType(prop, components, false);
        if (dartType.isRef && prop.ref != null) {
          String refClassName = _getRefClassName(prop.ref!);
          String fileName = convertToSnakeCase(refClassName);
          classBuffer.writeln('import \'$fileName${'_model'}.dart\';');
          withImport = true;
        }
        String propType = dartType.className;
        if (prop is ArrayProperty) {
          if (prop.items?.ref != null) {
            String itemRefClassName = _getRefClassName(prop.items!.ref!);
            String fileName = convertToSnakeCase(itemRefClassName);
            classBuffer.writeln('import \'$fileName${'_model'}.dart\';');
            propType = 'List<$itemRefClassName>';
            withImport = true;
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
            propName.replaceAll('.', '').replaceAll("/", ""));
        properties.add('  final $propType$nullableSuffix $camelCaseFieldName;');
      }
    }
    if (withImport) {
      classBuffer.writeln();
    }
    classBuffer.writeln('class $className {');
    for (final prop in properties) {
      classBuffer.writeln(prop);
    }
    classBuffer.writeln();
    if (schema is ObjectProperty && schema.properties != null) {
      classBuffer.writeln('  $className({');
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        String camelCaseFieldName = convertToCamelCase(
            propName.replaceAll('.', '').replaceAll("/", ""));
        classBuffer.writeln('    required this.$camelCaseFieldName,');
      }
      classBuffer.writeln('  });');
      classBuffer.writeln(
          '  factory $className.fromJson(Map<String, dynamic> json) {');
      classBuffer.writeln('    return $className(');
      for (var entry in schema.properties!.entries) {
        String propName = entry.key;
        String camelCaseFieldName =
            convertToCamelCase(propName.replaceAll('.', ''));
        classBuffer.writeln('      $camelCaseFieldName: json["$propName"],');
      }
      classBuffer.writeln('    );');
      classBuffer.writeln('  }');
    }
    classBuffer.writeln('}');
    return classBuffer.toString();
  }
}
