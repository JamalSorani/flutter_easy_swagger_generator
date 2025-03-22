// class SecuritySchemes {
//   final SecurityScheme accessToken;
//   final SecurityScheme refreshToken;
//   final SecurityScheme xApiKey;

//   SecuritySchemes({
//     required this.accessToken,
//     required this.refreshToken,
//     required this.xApiKey,
//   });

//   factory SecuritySchemes.fromJson(Map<String, dynamic> json) {
//     return SecuritySchemes(
//       accessToken:
//           SecurityScheme.fromJson(json['accessToken'] as Map<String, dynamic>),
//       refreshToken:
//           SecurityScheme.fromJson(json['refreshToken'] as Map<String, dynamic>),
//       xApiKey: SecurityScheme.fromJson(json['xApiKey'] as Map<String, dynamic>),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'accessToken': accessToken.toJson(),
//       'refreshToken': refreshToken.toJson(),
//       'xApiKey': xApiKey.toJson(),
//     };
//   }
// }

// class SecurityScheme {
//   final String scheme;
//   final String bearerFormat;
//   final String type;
//   final String description;
//   final String name;
//   final String inLocation;

//   SecurityScheme({
//     required this.scheme,
//     required this.bearerFormat,
//     required this.type,
//     required this.description,
//     required this.name,
//     required this.inLocation,
//   });

//   factory SecurityScheme.fromJson(Map<String, dynamic> json) {
//     return SecurityScheme(
//       scheme: json['scheme'] as String? ?? '',
//       bearerFormat: json['bearerFormat'] as String? ?? '',
//       type: json['type'] as String,
//       description: json['description'] as String? ?? '',
//       name: json['name'] as String? ?? '',
//       inLocation: json['in'] as String? ?? '',
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'scheme': scheme,
//       'bearerFormat': bearerFormat,
//       'type': type,
//       'description': description,
//       'name': name,
//       'in': inLocation,
//     };
//   }
// }
