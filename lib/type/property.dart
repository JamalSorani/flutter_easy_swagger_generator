import 'array_property.dart';
import 'object_property.dart';
import 'primitive_property.dart';
import 'ref_property.dart';

class IProperty {
  final IPrimitiveProperty? primitive;
  final IArrayProperty? array;
  final IRefProperty? ref;
  final IObjectProperty? object;
  final String? timeSpanRef; // Represents the TimeSpan reference
  final bool? nullable;
  final List<dynamic>? enumValues; // Represents enum
  final List<IProperty>? oneOf; // Match one of them
  final List<IProperty>? anyOf; // Each element must be one of them
  final List<IProperty>? allOf; // Merge them to a single object
  final Map<String, dynamic>? anyValue; // Represents any type

  IProperty({
    required this.primitive,
    required this.array,
    required this.ref,
    required this.object,
    required this.timeSpanRef, // used when the object refers to System.TimeSpan
    required this.nullable,
    required this.enumValues,
    required this.oneOf,
    required this.anyOf,
    required this.allOf,
    required this.anyValue,
  });

  factory IProperty.fromJson(Map<String, dynamic> json) {
    if (json["type"] == "array") {
      return IProperty(
        array: IArrayProperty.fromJson(json),
        primitive: null,
        ref: null,
        object: null,
        timeSpanRef: null,
        nullable: json["nullable"],
        enumValues: json["enum"],
        oneOf: null,
        anyOf: null,
        allOf: null,
        anyValue: null,
      );
    } else if (json["\$ref"] != null) {
      return IProperty(
        ref: IRefProperty.fromJson(json),
        primitive: null,
        array: null,
        object: null,
        timeSpanRef: null,
        nullable: json["nullable"],
        enumValues: json["enum"],
        oneOf: null,
        anyOf: null,
        allOf: null,
        anyValue: null,
      );
    } else if (json["type"] == "object" ||
        (json["properties"] != null && json["type"] != "array")) {
      return IProperty(
        object: IObjectProperty.fromJson(json),
        primitive: null,
        array: null,
        ref: null,
        timeSpanRef: null,
        nullable: json["nullable"],
        enumValues: json["enum"],
        oneOf: null,
        anyOf: null,
        allOf: null,
        anyValue: null,
      );
    } else {
      return IProperty(
        primitive: IPrimitiveProperty.fromJson(json),
        array: null,
        ref: null,
        object: null,
        timeSpanRef: null,
        nullable: json["nullable"],
        enumValues: json["enum"],
        oneOf: null,
        anyOf: null,
        allOf: null,
        anyValue: null,
      );
    }
  }
}
