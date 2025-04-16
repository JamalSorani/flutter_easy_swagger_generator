import 'package:flutter_easy_swagger_generator/classes/components.dart';
import '../classes/property.dart';
import '../classes/dart_type_info.dart';

DartTypeInfo getDartType(TProperty? schema, Components components) {
  if (schema?.ref != null) {
    schema!;

    // Extract schema name from $ref
    final ref = schema.ref!.split('/').last.split('.');
    final schemaName = ref.last.toString().toLowerCase() == "request"
        ? ref[ref.length - 2]
        : ref.last;

    String? type = components.schemas[schema.ref!.split('/').last]?.type;
    if (type != null && type != "object") {
      return _type(type, schema);
    }
    // Convert to PascalCase
    return DartTypeInfo(className: schemaName, schema: schema, isRef: true);
  }
  final swaggerType = schema?.type;
  return _type(swaggerType, schema);
}

DartTypeInfo _type(String? type, dynamic schema) {
  switch (type) {
    case 'string':
      return DartTypeInfo(className: 'String', schema: schema);
    case 'integer':
      return DartTypeInfo(className: 'int', schema: schema);
    case 'number':
      return DartTypeInfo(className: 'double', schema: schema);
    case 'boolean':
      return DartTypeInfo(className: 'bool', schema: schema);
    default:
      return DartTypeInfo(className: 'dynamic', schema: schema);
  }
}
