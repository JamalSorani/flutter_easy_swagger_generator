import 'property.dart';

class MediaTypeContent {
  final TProperty? schema;

  MediaTypeContent({this.schema});

  factory MediaTypeContent.fromJson(Map<String, dynamic> json) {
    return MediaTypeContent(
      schema:
          json["schema"] == null ? null : TProperty.fromJson(json["schema"]),
    );
  }
}
