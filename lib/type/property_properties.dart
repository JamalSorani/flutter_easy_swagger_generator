import 'property.dart';

class IPropertyProperties {
  final Map<String, IProperty> properties;

  IPropertyProperties(this.properties);

  @override
  String toString() {
    return 'IPropertyProperties{ properties: $properties }';
  }

  factory IPropertyProperties.fromJson(Map<String, dynamic> json) {
    return IPropertyProperties(
      (json).map(
        (key, value) => MapEntry(key, IProperty.fromJson(value)),
      ),
    );
  }
}
