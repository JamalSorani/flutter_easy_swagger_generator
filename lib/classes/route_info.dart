import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Represents a single API route entry parsed from the OpenAPI `paths` map.
///
/// Each [RouteInfo] binds a concrete `fullRoute` (e.g. `/api/Mobile/Event/GetEventById`)
/// with the detected HTTP method and its associated metadata in [HttpMethodInfo].
class RouteInfo {
  /// The full endpoint path as declared in the OpenAPI document.
  final String fullRoute;

  /// The HTTP method associated with [fullRoute] (e.g., GET, POST, DELETE).
  final HttpMethodType httpMethod;

  /// Detailed method information (summary, parameters, requestBody, responses, etc.).
  final HttpMethodInfo httpMethodInfo;

  /// Creates a [RouteInfo] for a specific path + method combination.
  RouteInfo({
    required this.fullRoute,
    required this.httpMethod,
    required this.httpMethodInfo,
  });

  /// Builds a [RouteInfo] from a JSON node representing a single path item.
  ///
  /// The [json] map is expected to contain one or more HTTP method keys
  /// (e.g., `get`, `post`, `delete`) with their corresponding details.
  /// The [fullRoute] parameter is the path key from the parent `paths` object.
  factory RouteInfo.fromJson(Map<String, dynamic> json, String fullRoute) {
    late HttpMethodType httpMethod;
    late HttpMethodInfo httpMethodInfo;
    json.forEach((method, info) {
      info as Map<String, dynamic>;
      httpMethod = HttpMethodType.values.firstWhere((e) {
        return e.name.toLowerCase() == method.toLowerCase();
      }, orElse: () {
        //TODO add error handler to add new type
        return HttpMethodType.values.first;
      });
      httpMethodInfo = HttpMethodInfo.fromJson(info);
    });
    return RouteInfo(
      fullRoute: fullRoute,
      httpMethod: httpMethod,
      httpMethodInfo: httpMethodInfo,
    );
  }
}



/*Example:

    "/api/Mobile//GetMyProfile": {
      "get": {
        "tags": [
          ""
        ],
        "parameters": [
          {
            "name": "X-TimeZoneId",
            "in": "header",
            "required": true,
            "schema": {
              "type": "string"
            },
            "example": "America/New_York"
          },
          {
            "name": "lang",
            "in": "header",
            "allowEmptyValue": true,
            "schema": {
              "enum": [
                "ar",
                "en",
                "fr",
                "de",
                "ru",
                "es",
                "zh",
                "ja",
                "ko",
                "hi",
                "tr",
                "fa",
                "ku",
                "nl"
              ],
              "type": "string"
            },
            "example": "en"
          },
          {
            "name": "DebugMode",
            "in": "header",
            "allowEmptyValue": true,
            "schema": {
              "type": "boolean"
            },
            "example": true
          }
        ],
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
      }
    },
*/