import 'package:flutter_easy_swagger_generator/enums/content_type.dart';

import 't_property.dart';

class MediaTypeContent {
  final TContentType contentType;

  final TProperty? schema;

  MediaTypeContent({
    required this.contentType,
    required this.schema,
  });

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
