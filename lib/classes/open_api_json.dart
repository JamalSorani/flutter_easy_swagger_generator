import 'package:flutter_easy_swagger_generator/classes/route_info.dart';

import 'components.dart';
import 'server.dart';
import 'info.dart';

/// Represents the root structure of an OpenAPI JSON specification.
class OpenApiJSON {
  /// The OpenAPI version, e.g., "3.0.0".
  final String openapi;

  /// General information about the API, such as title and version.
  final Info info;

  /// Map of paths to their HTTP methods and details.
  /// The outer map's key is the endpoint path, e.g., "/users".
  /// The inner map's key is the HTTP method, e.g., "get", "post".
  final List<RouteInfo> paths;

  /// Optional list of tags used to group API endpoints.
  final List<String>? tags;

  /// Optional list of server objects specifying API server URLs.
  final List<Server>? servers;

  /// Components section containing schemas, parameters, and other reusable objects.
  final Components components;

  /// Constructor for [OpenApiJSON].
  OpenApiJSON({
    required this.openapi,
    required this.info,
    required this.paths,
    required this.tags,
    required this.servers,
    required this.components,
  });

  /// Creates an [OpenApiJSON] instance from a JSON map.
  factory OpenApiJSON.fromJson(Map<String, dynamic> json) {
    final openApi = json["openapi"] ?? "";
    print("The OpenAPI version: $openApi");

    List<RouteInfo> paths = [];
    (json["paths"] as Map<String, dynamic>).forEach((key, value) {
      paths.add(RouteInfo.fromJson(value, key));
    });
    return OpenApiJSON(
      openapi: openApi,
      info: Info.fromJson(json["info"]),
      paths: paths,
      tags: (json["tags"] as List?)?.map((e) => e.toString()).toList(),
      servers:
          (json["servers"] as List?)?.map((e) => Server.fromJson(e)).toList(),
      components: Components.fromJson(json["components"] ?? {}),
    );
  }
}
