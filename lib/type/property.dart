class PrimitiveProperty implements IProperty {
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

class ArrayProperty implements IProperty {
  @override
  final String? type;
  @override
  final String? ref;
  @override
  final bool? nullable;
  final IProperty? items;

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
          : IProperty.fromJson(json['items'] as Map<String, dynamic>),
    );
  }
}

class RefProperty implements IProperty {
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

class ObjectProperty implements IProperty {
  @override
  final String? type;
  @override
  final String? ref;
  @override
  final bool? nullable;
  final Map<String, IProperty>? properties;
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
          IProperty.fromJson(value as Map<String, dynamic>),
        ),
      ),
      additionalProperties: json['additionalProperties'],
    );
  }
}

class IProperty {
  final String? type;
  final String? ref;
  final bool? nullable;

  IProperty({
    this.type,
    this.ref,
    this.nullable,
  });

  factory IProperty.fromJson(Map<String, dynamic> json) {
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
