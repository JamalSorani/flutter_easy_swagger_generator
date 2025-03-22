import 'parameter.dart';
import 'request_body.dart';
import 'response.dart';

class HttpMethodInfo {
  final String? summary; // Optional summary for the method
  final String? description; // Optional description
  final List<IParameter>? parameters; // Optional parameters
  final IRequestBody? requestBody; // Optional request body
  final IResponse responses; // Required responses

  HttpMethodInfo({
    this.summary,
    this.description,
    this.parameters,
    this.requestBody,
    required this.responses,
  });

  @override
  String toString() {
    return 'HttpMethodInfo{summary: $summary, description: $description, parameters: $parameters, requestBody: $requestBody, responses: $responses}';
  }
}
