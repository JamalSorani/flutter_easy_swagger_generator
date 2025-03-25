class PrimitiveProperty implements IProperty {
  @override
  final String? type;
  @override
  final String? ref;
  @override
  final bool? nullable;
  @override
  final List<dynamic>? enumeration;
  @override
  final List<IProperty>? oneOf;
  @override
  final List<IProperty>? anyOf;
  @override
  final List<IProperty>? allOf;
  @override
  final dynamic anyValue;

  PrimitiveProperty(
      {this.type,
      this.ref,
      this.nullable,
      this.enumeration,
      this.oneOf,
      this.anyOf,
      this.allOf,
      this.anyValue});

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
  @override
  final List<dynamic>? enumeration;
  @override
  final List<IProperty>? oneOf;
  @override
  final List<IProperty>? anyOf;
  @override
  final List<IProperty>? allOf;
  @override
  final dynamic anyValue;
  final IProperty? items;

  ArrayProperty(
      {this.items,
      this.ref,
      this.nullable,
      this.enumeration,
      this.oneOf,
      this.anyOf,
      this.allOf,
      this.anyValue,
      this.type = "array"});

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
  @override
  final List<dynamic>? enumeration;
  @override
  final List<IProperty>? oneOf;
  @override
  final List<IProperty>? anyOf;
  @override
  final List<IProperty>? allOf;
  @override
  final dynamic anyValue;

  RefProperty({
    this.ref,
    this.type,
    this.nullable,
    this.enumeration,
    this.oneOf,
    this.anyOf,
    this.allOf,
    this.anyValue,
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
  @override
  final List<dynamic>? enumeration;
  @override
  final List<IProperty>? oneOf;
  @override
  final List<IProperty>? anyOf;
  @override
  final List<IProperty>? allOf;
  @override
  final dynamic anyValue;
  final Map<String, IProperty>? properties;
  final dynamic additionalProperties;

  ObjectProperty(
      {this.properties,
      this.additionalProperties,
      this.ref,
      this.nullable,
      this.enumeration,
      this.oneOf,
      this.anyOf,
      this.allOf,
      this.anyValue,
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
  final List<dynamic>? enumeration;
  final List<IProperty>? oneOf;
  final List<IProperty>? anyOf;
  final List<IProperty>? allOf;
  final dynamic anyValue;

  IProperty({
    this.type,
    this.ref,
    this.nullable,
    this.enumeration,
    this.oneOf,
    this.anyOf,
    this.allOf,
    this.anyValue,
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


// import 'array_property.dart';
// import 'object_property.dart';
// import 'primitive_property.dart';
// import 'ref_property.dart';

// class IProperty {
//   final IPrimitiveProperty? primitive;
//   final IArrayProperty? array;
//   final IRefProperty? ref;
//   final IObjectProperty? object;
//   final String? timeSpanRef; // Represents the TimeSpan reference
//   final bool? nullable;
//   final List<dynamic>? enumValues; // Represents enum
//   final List<IProperty>? oneOf; // Match one of them
//   final List<IProperty>? anyOf; // Each element must be one of them
//   final List<IProperty>? allOf; // Merge them to a single object
//   final Map<String, dynamic>? anyValue; // Represents any type

//   IProperty({
//     required this.primitive,
//     required this.array,
//     required this.ref,
//     required this.object,
//     required this.timeSpanRef, // used when the object refers to System.TimeSpan
//     required this.nullable,
//     required this.enumValues,
//     required this.oneOf,
//     required this.anyOf,
//     required this.allOf,
//     required this.anyValue,
//   });

//   factory IProperty.fromJson(Map<String, dynamic> json) {
//     if (json["type"] == "array") {
//       return IProperty(
//         array: IArrayProperty.fromJson(json),
//         primitive: null,
//         ref: null,
//         object: null,
//         timeSpanRef: null,
//         nullable: json["nullable"],
//         enumValues: json["enum"],
//         oneOf: null,
//         anyOf: null,
//         allOf: null,
//         anyValue: null,
//       );
//     } else if (json["\$ref"] != null) {
//       return IProperty(
//         ref: IRefProperty.fromJson(json),
//         primitive: null,
//         array: null,
//         object: null,
//         timeSpanRef: null,
//         nullable: json["nullable"],
//         enumValues: json["enum"],
//         oneOf: null,
//         anyOf: null,
//         allOf: null,
//         anyValue: null,
//       );
//     } else if (json["type"] == "object" ||
//         (json["properties"] != null && json["type"] != "array")) {
//       return IProperty(
//         object: IObjectProperty.fromJson(json),
//         primitive: null,
//         array: null,
//         ref: null,
//         timeSpanRef: null,
//         nullable: json["nullable"],
//         enumValues: json["enum"],
//         oneOf: null,
//         anyOf: null,
//         allOf: null,
//         anyValue: null,
//       );
//     } else {
//       return IProperty(
//         primitive: IPrimitiveProperty.fromJson(json),
//         array: null,
//         ref: null,
//         object: null,
//         timeSpanRef: null,
//         nullable: json["nullable"],
//         enumValues: json["enum"],
//         oneOf: null,
//         anyOf: null,
//         allOf: null,
//         anyValue: null,
//       );
//     }
//   }
// }
