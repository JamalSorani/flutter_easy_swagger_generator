import 'property.dart';

class IArrayProperty {
  final String type; // This will always be "array"
  final TProperty? items; // This is optional

  const IArrayProperty(this.items) : type = "array";

  @override
  String toString() {
    return 'IArrayProperty{ type: $type, items: $items }';
  }

  factory IArrayProperty.fromJson(Map<String, dynamic> json) {
    return IArrayProperty(
      json["items"] == null ? null : TProperty.fromJson(json["items"]),
    );
  }
}
