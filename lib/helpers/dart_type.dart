import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Determines the Dart type information for a given Swagger schema.
///
/// - If [schema] is `null`, defaults to `dynamic`.
/// - If the schema is an array, resolves the type of the array items.
/// - If the schema has a `$ref`, resolves the referenced type from [components].
/// - Otherwise, falls back to mapping Swagger primitive types
///   (`string`, `integer`, `number`, `boolean`) to Dart types.
///
/// [isForEntities] controls whether the suffix `Param` (for entities)
/// or `Model` (for infrastructure models) is used when resolving class names.
///
/// Returns a [DartTypeInfo] containing:
/// - The Dart type/class name.
/// - The original schema.
/// - Whether the type was resolved from a `$ref`.
DartTypeInfo getDartType(
  TProperty? schema,
  Components components,
  bool isForEntities,
) {
  if (schema == null) {
    return DartTypeInfo(className: 'dynamic', schema: null);
  }

  String endPoint = isForEntities ? 'Param' : 'Model';

  // Handle array types
  if (schema is ArrayProperty) {
    final itemType = getDartType(schema.items, components, isForEntities);
    return DartTypeInfo(
      className: 'List<${itemType.className}>',
      schema: schema,
      isSubclass: true,
    );
  }

  // Handle referenced schemas
  if (schema.ref != null) {
    final ref = schema.ref!.split('/').last;
    final refParts = ref.split('.');

    // Shared reference types
    if (ref.contains('.Shared.')) {
      return DartTypeInfo(
        className: refParts.last + endPoint,
        schema: schema,
        isSubclass: true,
      );
    }

    // Handle request/response schema naming
    final schemaName = refParts.last.toString().toLowerCase() == "request"
        ? refParts[refParts.length - 2]
        : refParts.last;

    // Map primitive types directly, otherwise use referenced class
    String? type = components.schemas[ref]?.type.name;
    if (type != null && type != "ObjectProperty") {
      return _type(type, components.schemas[ref]!, enumName: schemaName);
    }
    return DartTypeInfo(
      className: schemaName + endPoint,
      schema: schema,
      isSubclass: true,
    );
  }

  // Handle primitive Swagger types
  return _type(schema.type.name, schema);
}

/// Maps a Swagger primitive type string to its Dart equivalent.
///
/// - `"string"` → `String`
/// - `"integer"` → `int`
/// - `"number"` → `double`
/// - `"boolean"` → `bool`
/// - anything else → `dynamic`
DartTypeInfo _type(
  String? type,
  TProperty schema, {
  String? enumName,
}) {
  if (enumName != null && (schema.enumValues.isNotEmpty)) {
    return DartTypeInfo(
      className: "${enumName}Enum",
      schema: schema,
      isEnum: true,
    );
  }
  switch (type) {
    case 'string':
      return DartTypeInfo(className: 'String', schema: schema);
    case 'integer':
      return DartTypeInfo(className: 'int', schema: schema);
    case 'number':
      return DartTypeInfo(className: 'num', schema: schema);
    case 'boolean':
      return DartTypeInfo(className: 'bool', schema: schema);
    case 'file':
      return DartTypeInfo(className: 'File', schema: schema);
    case 'date':
      return DartTypeInfo(className: 'DateTime', schema: schema);
    default:
      return DartTypeInfo(className: 'dynamic', schema: schema);
  }
}

/// Represents type information derived from a Swagger schema.
///
/// - [className] is the resolved Dart type or class name.
/// - [schema] holds the original Swagger property.
/// - [isSubclass] indicates if the type was resolved from a `$ref`.
class DartTypeInfo {
  final String className;
  final TProperty? schema;
  final bool isSubclass;
  final bool isEnum;

  DartTypeInfo({
    required this.className,
    required this.schema,
    this.isSubclass = false,
    this.isEnum = false,
  });
}
