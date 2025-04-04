import 'media_type.dart';

class TRequestBody {
  final String? description;
  final Map<String, MediaTypeContent>? content;

  TRequestBody({this.description, this.content});

  @override
  String toString() {
    return 'IRequestBody{description: $description, content: $content}';
  }

  factory TRequestBody.fromJson(Map<String, dynamic> json) {
    return TRequestBody(
      description: json["description"],
      content: (json["content"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, MediaTypeContent.fromJson(value)),
      ),
    );
  }
}
