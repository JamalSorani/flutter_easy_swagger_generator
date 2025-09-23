import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Represents a parameter in an API endpoint, such as query, path, header, or cookie parameters.
///
/// Mirrors the OpenAPI Parameter Object for fields commonly used by this generator.
class TParameter {
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

  /// Whether empty values are allowed for this parameter.
  ///
  /// Note: In OpenAPI 3.0, `allowEmptyValue` applies to `query` params only.
  /// Some backends also interpret it for headers; this generator preserves the
  /// flag for downstream handling and documentation.
  final bool allowEmptyValue;

  /// Example value for this parameter, used for documentation and testing.
  final dynamic example;

  /// Optional format hint (e.g., `uuid`, `date-time`, custom strings).
  /// Consumers may use this to customize (de)serialization or display.
  final String? format;

  /// Constructor for [TParameter].
  ///
  /// Ensures that [inn] is one of `"query"`, `"header"`, or `"path"`.
  TParameter({
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

  /// Creates a [TParameter] instance from a decoded OpenAPI Parameter JSON.
  ///
  /// Parses `name`, `in`, `schema`, `required`, `type` (when present),
  /// `allowEmptyValue`, `example`, and `format`.
  factory TParameter.fromJson(Map<String, dynamic> json) {
    return TParameter(
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
