import 'dart:core';

import 'property.dart';

class IParameter {
  final String name; // The name of the parameter
  final String inn; // Can be "query", "header", or "path"
  final TProperty? schema; // Optional schema of type IProperty
  final bool? required; // Optional, indicates if the parameter is required
  final String? type;

  // Constructor
  IParameter({
    required this.name,
    required this.inn,
    this.schema,
    this.required,
    this.type,
  }) : assert(inn == "query" || inn == "header" || inn == "path",
            'The "in" field must be either "query", "header", or "path"');

  @override
  String toString() {
    return 'IParameter{name: $name, in: $inn, schema: $schema, required: $required}';
  }

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
