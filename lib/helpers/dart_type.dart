import '../classes/property.dart';
import '../classes/dart_type_info.dart';

DartTypeInfo getDartType(TProperty? schema) {
  if (schema?.ref != null) {
    // Extract schema name from $ref
    final ref = schema!.ref!.split('/').last.split('.');
    final schemaName = ref.last.toString().toLowerCase() == "request"
        ? ref[ref.length - 2]
        : ref.last;

    // Convert to PascalCase
    return DartTypeInfo(className: schemaName, schema: schema);
  }
  final swaggerType = schema?.type;
  switch (swaggerType) {
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
