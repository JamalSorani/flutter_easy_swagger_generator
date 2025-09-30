/// Represents a primitive schema property (e.g., string, integer, number, boolean).
///
/// Captures optional `format`, `enum` values, and `default` when present.
class PrimitiveProperty implements TProperty {
  @override
  final TPropertyType type;

  @override
  final String? ref;

  @override
  final bool nullable;

  @override
  final String? format;

  @override
  final dynamic defaultValue;

  @override
  final List<String> enumValues;

  @override
  final TProperty? items;

  PrimitiveProperty({
    required this.type,
    this.ref,
    required this.nullable,
    this.format,
    required this.enumValues,
    this.defaultValue,
    this.items,
  });

  /// Creates a [PrimitiveProperty] from a JSON Schema fragment.
  factory PrimitiveProperty.fromJson(Map<String, dynamic> json) {
    late TPropertyType tPropertyType;
    if (json['format'] == "binary") {
      tPropertyType = TPropertyType.file;
    } else if (json['format']?.toString().contains("date") == true) {
      tPropertyType = TPropertyType.date;
    } else {
      tPropertyType = TPropertyType.values.firstWhere(
        (e) {
          return e.name == (json['type'].toString());
        },
        orElse: () {
          return TPropertyType.string;
        },
      );
    }
    return PrimitiveProperty(
      type: tPropertyType,
      format: json['format'] as String?,
      enumValues: (json['enum'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      defaultValue: json['default'],
      nullable: json['nullable'] ?? false,
    );
  }
}

/// Represents an array schema property.
///
/// Contains the `items` schema, optional `format`, `enum`, `default`, and nullability.
class ArrayProperty implements TProperty {
  @override
  final TPropertyType type;

  @override
  final String? ref;

  @override
  final bool nullable;

  @override
  final String? format;

  @override
  final dynamic defaultValue;

  @override
  final List<String> enumValues;

  @override
  final TProperty? items;

  ArrayProperty({
    this.items,
    this.ref,
    required this.nullable,
    this.type = TPropertyType.ArrayProperty,
    required this.format,
    this.defaultValue,
    required this.enumValues,
  });

  /// Creates an [ArrayProperty] from a JSON Schema fragment.
  factory ArrayProperty.fromJson(Map<String, dynamic> json) {
    return ArrayProperty(
      items: json['items'] == null
          ? null
          : TProperty.fromJson(json['items'] as Map<String, dynamic>),
      format: json['format'] as String?,
      defaultValue: json['default'],
      nullable: json['nullable'] ?? false,
      enumValues: (json['enum'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

/// Represents a `$ref` schema that points to another component schema.
class RefProperty implements TProperty {
  @override
  final TPropertyType type;

  @override
  final String? ref;

  @override
  final bool nullable;

  @override
  final String? format;

  @override
  final dynamic defaultValue;

  @override
  final List<String> enumValues;

  @override
  final TProperty? items;

  RefProperty({
    this.ref,
    this.type = TPropertyType.RefProperty,
    required this.nullable,
    required this.format,
    this.defaultValue,
    required this.enumValues,
    this.items,
  });

  /// Creates a [RefProperty] from a JSON Schema fragment containing `$ref`.
  factory RefProperty.fromJson(Map<String, dynamic> json) {
    return RefProperty(
      ref: (json['\$ref'] as String?)?.replaceAll("#/components/schemas/", ""),
      format: json['format'] as String?,
      defaultValue: json['default'],
      nullable: json['nullable'] ?? false,
      enumValues: (json['enum'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

/// Represents an object schema property with nested properties and optional `additionalProperties`.
class ObjectProperty implements TProperty {
  @override
  final TPropertyType type;

  @override
  final String? ref;

  @override
  final bool nullable;

  /// The list of named child properties and their schemas.
  final List<PropertyNameAndSchema> properties;

  /// Additional properties allowed in the object, can be a schema or `true`/`false`.
  final dynamic additionalProperties;

  @override
  final String? format;

  @override
  final dynamic defaultValue;

  @override
  final List<String> enumValues;

  @override
  final TProperty? items;

  ObjectProperty({
    required this.properties,
    this.additionalProperties,
    this.ref,
    required this.nullable,
    this.type = TPropertyType.ObjectProperty,
    required this.format,
    this.defaultValue,
    required this.enumValues,
    this.items,
  });

  /// Creates an [ObjectProperty] from a JSON Schema fragment.
  factory ObjectProperty.fromJson(Map<String, dynamic> json) {
    List<PropertyNameAndSchema> properties = [];

    if (json['properties'] != null &&
        json['properties'] is Map<String, dynamic>) {
      (json['properties'] as Map<String, dynamic>).forEach(
        (key, value) {
          properties.add(
            PropertyNameAndSchema(
              propertyName: key,
              schema: TProperty.fromJson(value),
            ),
          );
        },
      );
    }

    return ObjectProperty(
      properties: properties,
      additionalProperties: json['additionalProperties'],
      format: json['format'] as String?,
      defaultValue: json['default'],
      nullable: json['nullable'] ?? false,
      enumValues: (json['enum'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }
}

/// Base type for any schema property, providing common fields used across variants.
class TProperty {
  final TPropertyType type;
  final String? ref;
  final bool nullable;
  final String? format;
  final dynamic defaultValue;
  final List<String> enumValues;
  final TProperty? items;

  TProperty({
    required this.type,
    required this.ref,
    required this.nullable,
    required this.format,
    required this.defaultValue,
    required this.enumValues,
    required this.items,
  });

  /// Factory that selects an appropriate [TProperty] implementation
  /// based on the JSON Schema node content (`type` or `$ref`).
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

/// Pair of a property name and its parsed schema.
class PropertyNameAndSchema {
  final String propertyName;
  final TProperty schema;

  PropertyNameAndSchema({
    required this.propertyName,
    required this.schema,
  });
}

/// Enumeration of supported schema property kinds and primitive types.
enum TPropertyType {
  PrimitiveProperty,
  RefProperty,
  ObjectProperty,
  ArrayProperty,
  string,
  integer,
  number,
  boolean,
  file,
  date,
}

/*Example:

        "parameters": [
          {
            "name": "X-TimeZoneId",
            "in": "header",
            "required": true,
            "schema": {
              "type": "string"
            },
            "example": "America/New_York"
          },
          {
            "name": "lang",
            "in": "header",
            "allowEmptyValue": true,
            "schema": {
              "enum": [
                "ar",
                "en",
                "fr",
                "de",
                "ru",
                "es",
                "zh",
                "ja",
                "ko",
                "hi",
                "tr",
                "fa",
                "ku",
                "nl"
              ],
              "type": "string"
            },
            "example": "en"
          },
          {
            "name": "DebugMode",
            "in": "header",
            "allowEmptyValue": true,
            "schema": {
              "type": "boolean"
            },
            "example": true
          }
        ],

*/
