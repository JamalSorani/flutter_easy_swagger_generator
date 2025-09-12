import 'media_type.dart';

/// Represents the request body of an API operation
class TRequestBody {
  /// Optional description of the request body
  final String? description;

  /// Maps media types (e.g., application/json) to their content details
  final Map<String, MediaTypeContent>? content;

  TRequestBody({this.description, this.content});

  /// Creates an instance from a JSON map
  factory TRequestBody.fromJson(Map<String, dynamic> json) {
    return TRequestBody(
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
