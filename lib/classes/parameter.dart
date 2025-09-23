import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Represents a parameter in an API endpoint, such as query, path, or header parameters.
class Parameter {
  /// The name of the parameter.
  final String name;

  /// The location of the parameter. Must be one of `"query"`, `"header"`, or `"path"`.
  final String inn;

  /// Optional schema describing the type of this parameter.
  final TProperty? schema;

  /// Optional flag indicating if the parameter is required.
  final bool required;

  /// Optional type of the parameter.
  final TPropertyType? type;

  final bool
      allowEmptyValue; //TODO add comment to tell developer that it accept empty value

  final dynamic
      example; //TODO add comment to tell developer that it accept empty value

  final String? format;

  /// Constructor for [Parameter].
  ///
  /// Ensures that [inn] is one of `"query"`, `"header"`, or `"path"`.
  Parameter({
    required this.name,
    required this.inn,
    required this.schema,
    required this.required,
    required this.type,
    required this.allowEmptyValue,
    required this.example,
    required this.format,
  }) : assert(
          inn == "query" || inn == "header" || inn == "path",
          'The "in" field must be either "query", "header", or "path"',
        );

  /// Creates an [Parameter] instance from a JSON map.
  factory Parameter.fromJson(Map<String, dynamic> json) {
    return Parameter(
      name: json["name"] ?? "",
      inn: json["in"] ?? "query",
      schema:
          json["schema"] == null ? null : TProperty.fromJson(json["schema"]),
      required: json["required"] ?? false,
      type: TPropertyType.values.firstWhere(
        (e) => e.toString() == json['type']?.toString(),
        orElse: () => TPropertyType.string,
      ),
      allowEmptyValue: json["allowEmptyValue"] ?? false,
      example: json["example"],
      format: json['format'] as String?,
    );
  }
}
