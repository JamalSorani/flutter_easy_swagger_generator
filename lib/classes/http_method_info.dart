import 'package:flutter_easy_swagger_generator/classes/t_parameter.dart';
import 'package:flutter_easy_swagger_generator/classes/t_request_body.dart';
import 'package:flutter_easy_swagger_generator/classes/response.dart';

/// Describes details of an HTTP operation (e.g., a `get` or `post` on a path)
/// as defined in the OpenAPI specification.
///
/// Includes summary/description, parameters, an optional request body, the
/// responses object, and associated tags for grouping.
class HttpMethodInfo {
  /// Short, human-readable summary of the operation.
  final String? summary;

  /// A more detailed description of the operation.
  final String? description;

  /// Operation parameters (query, header, path, cookie).
  final List<TParameter>? parameters;

  /// Optional request body definition for this operation.
  final TRequestBody? requestBody;

  /// Responses keyed by HTTP status code.
  final IResponse responses;

  /// Tags used to group this operation in API documentation.
  final List<String> tags;

  /// Creates an [HttpMethodInfo] with all parsed operation details.
  HttpMethodInfo({
    required this.summary,
    required this.description,
    required this.parameters,
    required this.requestBody,
    required this.responses,
    required this.tags,
  });

  /// Builds an [HttpMethodInfo] from an OpenAPI operation object JSON.
  factory HttpMethodInfo.fromJson(Map<String, dynamic> json) {
    return HttpMethodInfo(
      summary: json["summary"],
      description: json["description"],
      parameters: (json["parameters"] as List?)
          ?.map((e) => TParameter.fromJson(e))
          .toList(),
      requestBody: json["requestBody"] == null
          ? null
          : TRequestBody.fromJson(json["requestBody"]),
      responses: IResponse.fromJson(json["responses"]),
      tags: (json["tags"] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
