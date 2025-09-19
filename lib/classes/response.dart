import 'media_type.dart';

/// Represents an API response container, primarily handling the 200 response
class IResponse {
  /// Details for the 200 response, if any
  final ResponseDetails? response200;

  IResponse({required this.response200});

  /// Creates an instance from a JSON map
  factory IResponse.fromJson(Map<String, dynamic> json) {
    return IResponse(
      response200: json['200'] != null
          ? ResponseDetails.fromJson(json['200'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Represents details of a response, including description and content
class ResponseDetails {
  /// Optional description of the response
  final String? description;

  /// Maps media types (e.g., application/json) to their content details
  final MediaTypeContent? content;

  ResponseDetails({required this.description, required this.content});

  /// Creates an instance from a JSON map
  factory ResponseDetails.fromJson(Map<String, dynamic> json) {
    return ResponseDetails(
      description: json['description'] as String?,
      content: json['content'] == null
          ? null
          : MediaTypeContent.fromJson(
              json['content'] as Map<String, dynamic>,
            ),
    );
  }
}


/*
example:
 "responses": {
          "200": {
            "description": "OK",
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
          }
        }
*/