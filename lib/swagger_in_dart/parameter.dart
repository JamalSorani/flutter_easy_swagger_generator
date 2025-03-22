// import 'schema.dart';

// class Parameter {
//   final String? name;
//   final bool? required;
//   final String? inLocation;
//   final Schema? schema;

//   Parameter({
//     this.name,
//     this.required,
//     this.inLocation,
//     this.schema,
//   });

//   factory Parameter.fromJson(Map<String, dynamic> json) {
//     return Parameter(
//       name: json['name'] as String?,
//       required: json['required'] as bool?,
//       inLocation: json['in'] as String?,
//       schema: json['schema'] != null
//           ? Schema.fromJson(json['schema'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'required': required,
//       'in': inLocation,
//       'schema': schema?.toJson(),
//     };
//   }
// }
