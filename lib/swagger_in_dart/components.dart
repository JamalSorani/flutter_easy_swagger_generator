// import 'schema.dart';
// import 'security_scheme.dart';

// class Components {
//   final Map<String, Schema> schemas;
//   final SecuritySchemes securitySchemes;

//   Components({
//     required this.schemas,
//     required this.securitySchemes,
//   });

//   factory Components.fromJson(Map<String, dynamic> json) {
//     return Components(
//       schemas: (json['schemas'] as Map<String, dynamic>).map(
//         (key, value) =>
//             MapEntry(key, Schema.fromJson(value as Map<String, dynamic>)),
//       ),
//       securitySchemes: SecuritySchemes.fromJson(
//           json['securitySchemes'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'schemas': schemas.map((key, value) => MapEntry(key, value.toJson())),
//       'securitySchemes': securitySchemes.toJson(),
//     };
//   }
// }
