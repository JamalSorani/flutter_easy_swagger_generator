import 'package:flutter_easy_swagger_generator/classes/components.dart';
import '../classes/property.dart';
import '../classes/dart_type_info.dart';

DartTypeInfo getDartType(TProperty? schema, Components components) {
  if (schema == null) {
    return DartTypeInfo(className: 'dynamic', schema: null);
  }

  // Handle array type first
  if (schema is ArrayProperty) {
    final itemType = getDartType(schema.items, components);
    return DartTypeInfo(
        className: 'List<${itemType.className}>',
        schema: schema,
        isRef: itemType.isRef);
  }

  // Handle ref type
  if (schema.ref != null) {
    // Extract schema name from $ref
    final ref = schema.ref!.split('/').last;
    final refParts = ref.split('.');

    // For shared types, keep the full name
    if (ref.contains('.Shared.')) {
      return DartTypeInfo(
          className: refParts.last, schema: schema, isRef: true);
    }

    // For other types, handle request suffix
    final schemaName = refParts.last.toString().toLowerCase() == "request"
        ? refParts[refParts.length - 2]
        : refParts.last;

    String? type = components.schemas[ref]?.type;
    if (type != null && type != "object") {
      return _type(type, schema);
    }
    return DartTypeInfo(className: schemaName, schema: schema, isRef: true);
  }

  // Handle primitive types
  return _type(schema.type, schema);
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
