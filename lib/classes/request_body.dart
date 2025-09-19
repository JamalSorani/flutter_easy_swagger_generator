import 'media_type.dart';

/// Represents the request body of an API operation
class RequestBody {
  /// Optional description of the request body
  final String? description;

  /// Maps media types (e.g., application/json) to their content details
  final MediaTypeContent? content;

  RequestBody({
    required this.description,
    required this.content,
  });

  /// Creates an instance from a JSON map
  factory RequestBody.fromJson(Map<String, dynamic> json) {
    return RequestBody(
      description: json['description'] as String?,
      content: json['content'] == null
          ? null
          : MediaTypeContent.fromJson(
              json['content'] as Map<String, dynamic>,
            ),
    );
  }
}
