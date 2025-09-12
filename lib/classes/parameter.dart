import 'dart:core';
import 'property.dart';

/// Represents a parameter in an API endpoint, such as query, path, or header parameters.
class IParameter {
  /// The name of the parameter.
  final String name;

  /// The location of the parameter. Must be one of `"query"`, `"header"`, or `"path"`.
  final String inn;

  /// Optional schema describing the type of this parameter.
  final TProperty? schema;

  /// Optional flag indicating if the parameter is required.
  final bool? required;

  /// Optional type of the parameter.
  final String? type;

  /// Constructor for [IParameter].
  ///
  /// Ensures that [inn] is one of `"query"`, `"header"`, or `"path"`.
  IParameter({
    required this.name,
    required this.inn,
    this.schema,
    this.required,
    this.type,
  }) : assert(
          inn == "query" || inn == "header" || inn == "path",
          'The "in" field must be either "query", "header", or "path"',
        );

  /// Creates an [IParameter] instance from a JSON map.
  factory IParameter.fromJson(Map<String, dynamic> json) {
    return IParameter(
      name: json["name"] ?? "",
      inn: json["in"] ?? "query",
      schema:
          json["schema"] == null ? null : TProperty.fromJson(json["schema"]),
      required: json["required"],
      type: json['type'],
    );
  }
}
