import 'property.dart';

class IResponse {
  final ResponseDetails? response200;

  IResponse({this.response200});

  @override
  String toString() {
    return 'IResponse{response200: $response200}';
  }
}

class ResponseDetails {
  final String? description; // Optional description for the response
  final Map<String, MediaTypeContent>?
      content; // Maps media types to their content

  ResponseDetails({this.description, this.content});

  @override
  String toString() {
    return 'ResponseDetails{description: $description, content: $content}';
  }
}

class MediaTypeContent {
  final IProperty
      schema; // The schema representing the structure of the content

  MediaTypeContent({required this.schema});

  @override
  String toString() {
    return 'MediaTypeContent{schema: $schema}';
  }
}
