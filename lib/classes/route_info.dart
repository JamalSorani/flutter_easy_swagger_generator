import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class RouteInfo {
  final String fullRoute;
  final HttpMethodType httpMethod;
  final HttpMethodInfo httpMethodInfo;

  RouteInfo({
    required this.fullRoute,
    required this.httpMethod,
    required this.httpMethodInfo,
  });

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