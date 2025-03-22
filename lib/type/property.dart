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
    this.primitive,
    this.array,
    this.ref,
    this.object,
    this.timeSpanRef, // used when the object refers to System.TimeSpan
    this.nullable,
    this.enumValues,
    this.oneOf,
    this.anyOf,
    this.allOf,
    this.anyValue,
  });
}
