import 'property_properties.dart';

class IObjectProperty {
  final String type; // Always "object"
  final IPropertyProperties? properties; // Optional
  final dynamic additionalProperties; // Can be IProperty or true

  IObjectProperty({
    required this.type,
    this.properties,
    this.additionalProperties,
  }) : assert(type == "object", 'Type must be "object"');

  @override
  String toString() {
    return 'IObjectProperty{ type: $type, properties: $properties, additionalProperties: $additionalProperties }';
  }
}
