import 'package:flutter_easy_swagger_generator/type/parameter.dart';
import 'package:flutter_easy_swagger_generator/type/request_body.dart';
import 'package:flutter_easy_swagger_generator/type/response.dart';

class HttpMethodInfo {
  final String? summary;
  final String? description;
  final List<IParameter>? parameters;
  final IRequestBody? requestBody;
  final IResponse responses;
  final List<String> tags;

  HttpMethodInfo({
    required this.summary,
    required this.description,
    required this.parameters,
    required this.requestBody,
    required this.responses,
    required this.tags,
  });

  factory HttpMethodInfo.fromJson(Map<String, dynamic> json) {
    return HttpMethodInfo(
      summary: json["operationId"],
      description: json["description"],
      parameters: (json["parameters"] as List?)
          ?.map((e) => IParameter.fromJson(e))
          .toList(),
      requestBody: json["requestBody"] == null
          ? null
          : IRequestBody.fromJson(json["requestBody"]),
      responses: IResponse.fromJson(json["responses"]),
      tags: (json["tags"] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
