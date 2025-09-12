import 'media_type.dart';

/// Represents an API response container, primarily handling the 200 response
class IResponse {
  /// Details for the 200 response, if any
  final ResponseDetails? response200;

  IResponse({this.response200});

  /// Creates an instance from a JSON map
  factory IResponse.fromJson(Map<String, dynamic> json) {
    return IResponse(
      response200: json['200'] != null
          ? ResponseDetails.fromJson(json['200'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Represents details of a response, including description and content
class ResponseDetails {
  /// Optional description of the response
  final String? description;

  /// Maps media types (e.g., application/json) to their content details
  final Map<String, MediaTypeContent>? content;

  ResponseDetails({this.description, this.content});

  /// Creates an instance from a JSON map
  factory ResponseDetails.fromJson(Map<String, dynamic> json) {
    return ResponseDetails(
      description: json['description'] as String?,
      content: (json['content'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(
          key,
          MediaTypeContent.fromJson(value as Map<String, dynamic>),
        ),
      ),
    );
  }
}
