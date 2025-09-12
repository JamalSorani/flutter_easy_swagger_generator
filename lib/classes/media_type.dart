import 'property.dart';

/// Represents the content of a media type in a request or response.
class MediaTypeContent {
  /// Optional schema describing the structure of the media type content.
  final TProperty? schema;

  /// Constructs a [MediaTypeContent] with an optional [schema].
  MediaTypeContent({this.schema});

  /// Creates a [MediaTypeContent] from a JSON map.
  ///
  /// Parses the `schema` field into a [TProperty] if it exists.
  factory MediaTypeContent.fromJson(Map<String, dynamic> json) {
    return MediaTypeContent(
      schema:
          json["schema"] == null ? null : TProperty.fromJson(json["schema"]),
    );
  }
}
