// import 'components.dart';
// import '../type/info.dart';
// import 'path_item.dart';

// class Swagger {
//   final String openapi;
//   final Info info;
//   final Map<String, PathItem> paths;
//   final Components components;

//   Swagger({
//     required this.openapi,
//     required this.info,
//     required this.paths,
//     required this.components,
//   });

//   factory Swagger.fromJson(Map<String, dynamic> json) {
//     return Swagger(
//       openapi: json['openapi'] as String,
//       info: Info.fromJson(json['info'] as Map<String, dynamic>),
//       paths: (json['paths'] as Map<String, dynamic>).map(
//         (key, value) =>
//             MapEntry(key, PathItem.fromJson(value as Map<String, dynamic>)),
//       ),
//       components:
//           Components.fromJson(json['components'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'openapi': openapi,
//       'info': info.toJson(),
//       'paths': paths.map((key, value) => MapEntry(key, value.toJson())),
//       'components': components.toJson(),
//     };
//   }
// }
