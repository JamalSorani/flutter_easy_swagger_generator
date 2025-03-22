// class Schema {
//   final String? type;
//   final String? format;
//   final String? description;
//   final bool? nullable;
//   final String? example;
//   final List<String>? enumValues;
//   final Schema? items;
//   final Map<String, Schema>? properties;
//   final List<String>? requiredProperties;
//   final List<Schema>? allOf;
//   final List<Schema>? oneOf;
//   final String? ref;
//   final int? minimum;
//   final int? maximum;
//   final bool? exclusiveMinimum;
//   final bool? exclusiveMaximum;
//   final int? minLength;
//   final int? maxLength;
//   final bool? toLowerCase;
//   final String? title;

//   Schema({
//     this.type = '',
//     this.format = '',
//     this.description,
//     this.nullable,
//     this.example,
//     this.enumValues,
//     this.items,
//     this.properties,
//     this.requiredProperties,
//     this.allOf,
//     this.oneOf,
//     this.ref,
//     this.minimum,
//     this.maximum,
//     this.exclusiveMinimum,
//     this.exclusiveMaximum,
//     this.minLength,
//     this.maxLength,
//     this.toLowerCase,
//     this.title,
//   });

//   factory Schema.fromJson(Map<String, dynamic> json) {
//     return Schema(
//       type: json['type'] as String? ?? '',
//       format: json['format'] as String? ?? '',
//       description: json['description'] as String?,
//       nullable: json['nullable'] as bool?,
//       example: json['example'] as String?,
//       enumValues:
//           (json['enum'] as List<dynamic>?)?.map((e) => e as String).toList(),
//       items: json['items'] != null
//           ? Schema.fromJson(json['items'] as Map<String, dynamic>)
//           : null,
//       properties: (json['properties'] as Map<String, dynamic>?)?.map(
//         (key, value) =>
//             MapEntry(key, Schema.fromJson(value as Map<String, dynamic>)),
//       ),
//       requiredProperties: (json['required'] as List<dynamic>?)
//           ?.map((e) => e as String)
//           .toList(),
//       allOf: (json['allOf'] as List<dynamic>?)
//           ?.map((e) => Schema.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       oneOf: (json['oneOf'] as List<dynamic>?)
//           ?.map((e) => Schema.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       ref: json['\$ref'] as String?,
//       minimum: json['minimum'] as int?,
//       maximum: json['maximum'] as int?,
//       exclusiveMinimum: json['exclusiveMinimum'] as bool?,
//       exclusiveMaximum: json['exclusiveMaximum'] as bool?,
//       minLength: json['minLength'] as int?,
//       maxLength: json['maxLength'] as int?,
//       toLowerCase: json['toLowerCase'] as bool?,
//       title: json['title'] as String?,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'type': type,
//       'format': format,
//       'description': description,
//       'nullable': nullable,
//       'example': example,
//       'enum': enumValues,
//       'items': items?.toJson(),
//       'properties':
//           properties?.map((key, value) => MapEntry(key, value.toJson())),
//       'required': requiredProperties,
//       'allOf': allOf?.map((e) => e.toJson()).toList(),
//       'oneOf': oneOf?.map((e) => e.toJson()).toList(),
//       '\$ref': ref,
//       'minimum': minimum,
//       'maximum': maximum,
//       'exclusiveMinimum': exclusiveMinimum,
//       'exclusiveMaximum': exclusiveMaximum,
//       'minLength': minLength,
//       'maxLength': maxLength,
//       'toLowerCase': toLowerCase,
//       'title': title,
//     };
//   }
// }
