import 'package:flutter_easy_swagger_generator/enums/content_type.dart';

import 't_property.dart';

/// Represents a parsed media type entry from an OpenAPI `content` map.
///
/// Currently supports extracting schemas for `application/json` and
/// `multipart/form-data` entries.
class MediaTypeContent {
  /// The recognized content type (e.g., `application/json`, `multipart/form-data`).
  final TContentType contentType;

  /// The associated schema for this media type, if provided.
  final TProperty? schema;

  /// Creates a [MediaTypeContent] with a specific [contentType] and [schema].
  MediaTypeContent({
    required this.contentType,
    required this.schema,
  });

  /// Builds a [MediaTypeContent] from an OpenAPI `content` JSON object.
  ///
  /// Iterates the provided map and picks the first supported media type
  /// (`application/json` or `multipart/form-data`) and parses its `schema`.
  factory MediaTypeContent.fromJson(Map<String, dynamic> json) {
    late TContentType contentType;
    late TProperty schema;
    json.forEach((key, value) {
      final type = TContentType.fromString(key);
      if (type == TContentType.applicationJson ||
          type == TContentType.multipartFormData) {
        contentType = type;
        schema = TProperty.fromJson(value["schema"]);
      }
    });
    return MediaTypeContent(
      contentType: contentType,
      schema: schema,
    );
  }
}

/*Example:
            "content": {
              "text/plain": {
                "schema": {
                  "$ref": "#/components/schemas/Elkood.Application.OperationResponses.OperationResponse`1[[DAN.Application.App..Queries.GetMyProfile.GetMyProfileQuery.Response, DAN.Application.App, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null]]"
                }
              },
              "application/json": {
                "schema": {
                  "$ref": "#/components/schemas/Elkood.Application.OperationResponses.OperationResponse`1[[DAN.Application.App..Queries.GetMyProfile.GetMyProfileQuery.Response, DAN.Application.App, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null]]"
                }
              },
              "text/json": {
                "schema": {
                  "$ref": "#/components/schemas/Elkood.Application.OperationResponses.OperationResponse`1[[DAN.Application.App..Queries.GetMyProfile.GetMyProfileQuery.Response, DAN.Application.App, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null]]"
                }
              }
            }
*/
