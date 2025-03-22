// class SecurityRequirement {
//   final List<String>? accessToken;
//   final List<String>? refreshToken;
//   final List<String>? xApiKey;

//   SecurityRequirement({this.accessToken, this.refreshToken, this.xApiKey});

//   factory SecurityRequirement.fromJson(Map<String, dynamic> json) {
//     return SecurityRequirement(
//       accessToken: (json['accessToken'] as List<dynamic>?)
//           ?.map((e) => e as String)
//           .toList(),
//       refreshToken: (json['refreshToken'] as List<dynamic>?)
//           ?.map((e) => e as String)
//           .toList(),
//       xApiKey:
//           (json['xApiKey'] as List<dynamic>?)?.map((e) => e as String).toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'accessToken': accessToken,
//       'refreshToken': refreshToken,
//       'xApiKey': xApiKey,
//     };
//   }
// }
