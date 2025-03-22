// import 'parameter.dart';
// import 'request_body.dart';
// import 'responses.dart';
// import 'security_requirment.dart';

// class Operation {
//   final String? operationId;
//   final List<Parameter>? parameters;
//   final RequestBody? requestBody;
//   final Responses? responses;
//   final List<String>? tags;
//   final List<SecurityRequirement>? security;

//   Operation({
//     this.operationId,
//     this.parameters,
//     this.requestBody,
//     this.responses,
//     this.tags,
//     this.security,
//   });

//   factory Operation.fromJson(Map<String, dynamic> json) {
//     return Operation(
//       operationId: json['operationId'] as String?,
//       parameters: (json['parameters'] as List<dynamic>?)
//           ?.map((e) => Parameter.fromJson(e as Map<String, dynamic>))
//           .toList(),
//       requestBody: json['requestBody'] != null
//           ? RequestBody.fromJson(json['requestBody'] as Map<String, dynamic>)
//           : null,
//       responses: json['responses'] != null
//           ? Responses.fromJson(json['responses'] as Map<String, dynamic>)
//           : null,
//       tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
//       security: (json['security'] as List<dynamic>?)
//           ?.map((e) => SecurityRequirement.fromJson(e as Map<String, dynamic>))
//           .toList(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'operationId': operationId,
//       'parameters': parameters?.map((e) => e.toJson()).toList(),
//       'requestBody': requestBody?.toJson(),
//       'responses': responses?.toJson(),
//       'tags': tags,
//       'security': security?.map((e) => e.toJson()).toList(),
//     };
//   }
// }
