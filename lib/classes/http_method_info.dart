import 'package:flutter_easy_swagger_generator/classes/parameter.dart';
import 'package:flutter_easy_swagger_generator/classes/request_body.dart';
import 'package:flutter_easy_swagger_generator/classes/response.dart';

/// Represents information about an HTTP method in the OpenAPI specification.
class HttpMethodInfo {
  /// The summary of the HTTP method. for example "Auth policies: HasUserTypes_1_"
  final String?
      summary; //TODO add comment to tell user that this is the summary

  /// A detailed description of the HTTP method.
  final String? description;

  /// List of parameters for the HTTP method (query, path, header, etc.).
  final List<Parameter>? parameters;

  /// Optional request body associated with the HTTP method.
  final RequestBody? requestBody;

  /// The response information for the HTTP method, typically including status 200.
  final IResponse responses;

  /// List of tags associated with the HTTP method for categorization.
  final List<String> tags;

  /// Constructs an [HttpMethodInfo] object with all its fields.
  HttpMethodInfo({
    required this.summary,
    required this.description,
    required this.parameters,
    required this.requestBody,
    required this.responses,
    required this.tags,
  });

  /// Creates an [HttpMethodInfo] instance from a JSON map.
  ///
  /// Parses `parameters`, `requestBody`, `responses`, and `tags` from the JSON structure.
  factory HttpMethodInfo.fromJson(Map<String, dynamic> json) {
    return HttpMethodInfo(
      summary: json["summary"],
      description: json["description"],
      parameters: (json["parameters"] as List?)
          ?.map((e) => Parameter.fromJson(e))
          .toList(),
      requestBody: json["requestBody"] == null
          ? null
          : RequestBody.fromJson(json["requestBody"]),
      responses: IResponse.fromJson(json["responses"]),
      tags: (json["tags"] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
