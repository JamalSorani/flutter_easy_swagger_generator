import './media_type.dart';

class IRequestBody {
  final String? description; // Optional description for the request body
  final Map<String, MediaTypeContent>?
      content; // Maps media types to their content

  IRequestBody({this.description, this.content});

  @override
  String toString() {
    return 'IRequestBody{description: $description, content: $content}';
  }

  factory IRequestBody.fromJson(Map<String, dynamic> json) {
    return IRequestBody(
      description: json["description"],
      content: (json["content"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, MediaTypeContent.fromJson(value)),
      ),
    );
  }
}
