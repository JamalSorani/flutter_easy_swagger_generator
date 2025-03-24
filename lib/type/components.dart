import 'property.dart';

class Components {
  final Map<String, IProperty> schemas;

  Components({required this.schemas});

  factory Components.fromJson(Map<String, dynamic> json) {
    return Components(
      schemas: (json["schemas"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, IProperty.fromJson(value)),
      ),
    );
  }
}
