import 'media_type.dart';

class IResponse {
  final ResponseDetails? response200;

  IResponse({this.response200});

  factory IResponse.fromJson(Map<String, dynamic> json) {
    return IResponse(
      response200:
          json["200"] == null ? null : ResponseDetails.fromJson(json["200"]),
    );
  }
}

class ResponseDetails {
  final String? description; // Optional description for the response
  final Map<String, MediaTypeContent>?
      content; // Maps media types to their content

  ResponseDetails({this.description, this.content});

  factory ResponseDetails.fromJson(Map<String, dynamic> json) {
    return ResponseDetails(
      description: json["description"],
      content: (json["content"] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, MediaTypeContent.fromJson(value)),
      ),
    );
  }
}
