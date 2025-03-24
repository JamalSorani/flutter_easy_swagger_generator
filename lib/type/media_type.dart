import './property.dart';

class MediaTypeContent {
  final IProperty? schema;

  MediaTypeContent({this.schema});

  factory MediaTypeContent.fromJson(Map<String, dynamic> json) {
    return MediaTypeContent(
      schema:
          json["schema"] == null ? null : IProperty.fromJson(json["schema"]),
    );
  }

  @override
  String toString() {
    return 'MediaTypeContent{schema: $schema}';
  }
}
