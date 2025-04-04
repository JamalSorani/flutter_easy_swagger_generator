class PrimitiveProperty implements TProperty {
  @override
  final String? type;
  @override
  final String? ref;
  @override
  final bool? nullable;
  @override
  PrimitiveProperty({
    this.type,
    this.ref,
    this.nullable,
  });

  factory PrimitiveProperty.fromJson(Map<String, dynamic> json) {
    return PrimitiveProperty(
      type: json['type'] as String?,
    );
  }
}

class ArrayProperty implements TProperty {
  @override
  final String? type;
  @override
  final String? ref;
  @override
  final bool? nullable;
  final TProperty? items;

  ArrayProperty({
    this.items,
    this.ref,
    this.nullable,
    this.type = "array",
  });

  factory ArrayProperty.fromJson(Map<String, dynamic> json) {
    return ArrayProperty(
      items: json['items'] == null
          ? null
          : TProperty.fromJson(json['items'] as Map<String, dynamic>),
    );
  }
}

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

  factory RefProperty.fromJson(Map<String, dynamic> json) {
    return RefProperty(
      ref: json['\$ref'] as String?,
      type: json['type'] as String?,
    );
  }
}

class ObjectProperty implements TProperty {
  @override
  final String? type;
  @override
  final String? ref;
  @override
  final bool? nullable;
  final Map<String, TProperty>? properties;
  final dynamic additionalProperties;

  ObjectProperty(
      {this.properties,
      this.additionalProperties,
      this.ref,
      this.nullable,
      this.type = "object"});

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

class TProperty {
  final String? type;
  final String? ref;
  final bool? nullable;

  TProperty({
    this.type,
    this.ref,
    this.nullable,
  });

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
