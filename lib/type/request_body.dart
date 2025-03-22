import 'response.dart';

class IRequestBody {
  final String? description; // Optional description for the request body
  final Map<String, MediaTypeContent>?
      content; // Maps media types to their content

  IRequestBody({this.description, this.content});

  @override
  String toString() {
    return 'IRequestBody{description: $description, content: $content}';
  }
}
