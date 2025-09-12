import 'property.dart';

/// Represents the components section of an OpenAPI specification,
/// primarily holding reusable schema definitions.
class Components {
  /// A map of schema names to their corresponding [TProperty] definitions.
  final Map<String, TProperty> schemas;

  /// Constructs a [Components] instance with the given [schemas].
  Components({required this.schemas});

  /// Creates a [Components] instance from a JSON map.
  factory Components.fromJson(Map<String, dynamic> json) {
    return Components(
      schemas: (json["schemas"] as Map<String, dynamic>?)?.map(
            (key, value) => MapEntry(key, TProperty.fromJson(value)),
          ) ??
          {},
    );
  }
}
