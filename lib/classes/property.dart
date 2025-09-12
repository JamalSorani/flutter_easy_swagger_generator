/// Represents a primitive property in an API schema, such as a string, number, or boolean.
class PrimitiveProperty implements TProperty {
  @override
  final String? type;

  @override
  final String? ref;

  @override
  final bool? nullable;

  /// Optional format of the primitive type (e.g., "date-time", "binary").
  final String? format;

  /// Optional list of enum values for string-based enums.
  final List<String>? enumValues;

  PrimitiveProperty({
    this.type,
    this.ref,
    this.nullable,
    this.format,
    this.enumValues,
  });

  /// Creates a [PrimitiveProperty] from a JSON map.
  factory PrimitiveProperty.fromJson(Map<String, dynamic> json) {
    return PrimitiveProperty(
      type: json['type'] as String?,
      format: json['format'] as String?,
      enumValues:
          (json['enum'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
    );
  }
}

/// Represents an array property in an API schema.
class ArrayProperty implements TProperty {
  @override
  final String? type;

  @override
  final String? ref;

  @override
  final bool? nullable;

  /// The type of items in the array.
  final TProperty? items;

  ArrayProperty({
    this.items,
    this.ref,
    this.nullable,
    this.type = "array",
  });

  /// Creates an [ArrayProperty] from a JSON map.
  factory ArrayProperty.fromJson(Map<String, dynamic> json) {
    return ArrayProperty(
      items: json['items'] == null
          ? null
          : TProperty.fromJson(json['items'] as Map<String, dynamic>),
    );
  }
}

/// Represents a reference property that points to another schema definition.
class RefProperty implements TProperty {
  @override
  final String? type;

  @override
  final String? ref;

  @override
  final bool? nullable;

  RefProperty({
    this.ref,
    this.type,
    this.nullable,
  });

  /// Creates a [RefProperty] from a JSON map.
  factory RefProperty.fromJson(Map<String, dynamic> json) {
    return RefProperty(
      ref: json['\$ref'] as String?,
      type: json['type'] as String?,
    );
  }
}

/// Represents an object property with nested properties.
class ObjectProperty implements TProperty {
  @override
  final String? type;

  @override
  final String? ref;

  @override
  final bool? nullable;

  /// Map of property names to their types.
  final Map<String, TProperty>? properties;

  /// Additional properties allowed in the object, can be a schema or `true`.
  final dynamic additionalProperties;

  ObjectProperty({
    this.properties,
    this.additionalProperties,
    this.ref,
    this.nullable,
    this.type = "object",
  });

  /// Creates an [ObjectProperty] from a JSON map.
  factory ObjectProperty.fromJson(Map<String, dynamic> json) {
    return ObjectProperty(
      properties: (json['properties'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          TProperty.fromJson(value as Map<String, dynamic>),
        ),
      ),
      additionalProperties: json['additionalProperties'],
    );
  }
}

/// Base class representing any property type in the API schema.
class TProperty {
  final String? type;
  final String? ref;
  final bool? nullable;

  TProperty({
    this.type,
    this.ref,
    this.nullable,
  });

  /// Factory method that creates the appropriate subclass based on JSON content.
  factory TProperty.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 'array') {
      return ArrayProperty.fromJson(json);
    } else if (json['type'] == 'object') {
      return ObjectProperty.fromJson(json);
    } else if (json['\$ref'] != null) {
      return RefProperty.fromJson(json);
    } else {
      return PrimitiveProperty.fromJson(json);
    }
  }
}
