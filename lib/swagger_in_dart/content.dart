// import 'media_type.dart';

// class Content {
//   final MediaType applicationJson;
//   final MediaType multipartFormData;

//   Content({required this.applicationJson, required this.multipartFormData});

//   factory Content.fromJson(Map<String, dynamic> json) {
//     return Content(
//       applicationJson: json['application/json'] != null
//           ? MediaType.fromJson(json['application/json'] as Map<String, dynamic>)
//           : MediaType(),
//       multipartFormData: json['multipart/form-data'] != null
//           ? MediaType.fromJson(
//               json['multipart/form-data'] as Map<String, dynamic>)
//           : MediaType(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'application/json': applicationJson.toJson(),
//       'multipart/form-data': multipartFormData.toJson(),
//     };
//   }
// }
