// import 'content.dart';

// class Responses {
//   final Response? success;
//   final Response? unauthorized;
//   final Response? forbidden;
//   final Response? notFound;
//   final Response? requestTimeout;
//   final Response? validationError;
//   final Response? internalServerError;
//   final Response? created;
//   final Response? badRequest;
//   final Response? noContent;

//   Responses(
//       {this.success,
//       this.unauthorized,
//       this.forbidden,
//       this.notFound,
//       this.requestTimeout,
//       this.validationError,
//       this.internalServerError,
//       this.created,
//       this.badRequest,
//       this.noContent});

//   factory Responses.fromJson(Map<String, dynamic> json) {
//     return Responses(
//       success: json['200'] != null
//           ? Response.fromJson(json['200'] as Map<String, dynamic>)
//           : null,
//       unauthorized: json['401'] != null
//           ? Response.fromJson(json['401'] as Map<String, dynamic>)
//           : null,
//       forbidden: json['403'] != null
//           ? Response.fromJson(json['403'] as Map<String, dynamic>)
//           : null,
//       notFound: json['404'] != null
//           ? Response.fromJson(json['404'] as Map<String, dynamic>)
//           : null,
//       requestTimeout: json['408'] != null
//           ? Response.fromJson(json['408'] as Map<String, dynamic>)
//           : null,
//       validationError: json['422'] != null
//           ? Response.fromJson(json['422'] as Map<String, dynamic>)
//           : null,
//       internalServerError: json['500'] != null
//           ? Response.fromJson(json['500'] as Map<String, dynamic>)
//           : null,
//       created: json['201'] != null
//           ? Response.fromJson(json['201'] as Map<String, dynamic>)
//           : null,
//       badRequest: json['400'] != null
//           ? Response.fromJson(json['400'] as Map<String, dynamic>)
//           : null,
//       noContent: json['204'] != null
//           ? Response.fromJson(json['204'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '200': success?.toJson(),
//       '401': unauthorized?.toJson(),
//       '403': forbidden?.toJson(),
//       '404': notFound?.toJson(),
//       '408': requestTimeout?.toJson(),
//       '422': validationError?.toJson(),
//       '500': internalServerError?.toJson(),
//       '201': created?.toJson(),
//       '400': badRequest?.toJson(),
//       '204': noContent?.toJson(),
//     };
//   }
// }

// class Response {
//   final String description;
//   final Content? content;

//   Response({
//     required this.description,
//     this.content,
//   });

//   factory Response.fromJson(Map<String, dynamic> json) {
//     return Response(
//       description: json['description'] as String,
//       content: json['content'] != null
//           ? Content.fromJson(json['content'] as Map<String, dynamic>)
//           : null,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'description': description,
//       'content': content?.toJson(),
//     };
//   }
// }
