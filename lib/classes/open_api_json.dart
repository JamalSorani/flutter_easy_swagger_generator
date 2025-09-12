import 'components.dart';
import 'http_method_info.dart';
import 'server.dart';
import 'info.dart';

/// Represents the root structure of an OpenAPI JSON specification.
class IOpenApiJSON {
  /// The OpenAPI version, e.g., "3.0.0".
  final String openapi;

  /// General information about the API, such as title and version.
  final Info info;

  /// Optional list of tags used to group API endpoints.
  final List<String>? tags;

  /// Optional list of server objects specifying API server URLs.
  final List<Server>? servers;

  /// Map of paths to their HTTP methods and details.
  /// The outer map's key is the endpoint path, e.g., "/users".
  /// The inner map's key is the HTTP method, e.g., "get", "post".
  final Map<String, Map<String, HttpMethodInfo>> paths;

  /// Components section containing schemas, parameters, and other reusable objects.
  final Components components;

  /// Constructor for [IOpenApiJSON].
  IOpenApiJSON({
    required this.openapi,
    required this.info,
    required this.tags,
    required this.servers,
    required this.paths,
    required this.components,
  });

  /// Creates an [IOpenApiJSON] instance from a JSON map.
  factory IOpenApiJSON.fromJson(Map<String, dynamic> json) {
    return IOpenApiJSON(
      openapi: json["openapi"] ?? "",
      info: Info.fromJson(json["info"]),
      tags: (json["tags"] as List?)?.map((e) => e.toString()).toList(),
      servers:
          (json["servers"] as List?)?.map((e) => Server.fromJson(e)).toList(),
      paths: (json["paths"] as Map<String, dynamic>).map((key, value) {
        return MapEntry(
          key,
          (value as Map<String, dynamic>).map((method, detail) {
            return MapEntry(method, HttpMethodInfo.fromJson(detail));
          }),
        );
      }),
      components: Components.fromJson(json["components"] ?? {}),
    );
  }
}
