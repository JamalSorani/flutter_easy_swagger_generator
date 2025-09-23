import 'package:flutter_easy_swagger_generator/classes/route_info.dart';

import 'components.dart';
import 'server.dart';
import 'info.dart';

/// Represents the root structure of an OpenAPI (3.x) specification document.
///
/// This class aggregates high-level metadata (`info`), the available API
/// `paths`, reusable `components`, optional `servers`, and optional top-level
/// `tags` as described by the OpenAPI specification.
class OpenApiJSON {
  /// The OpenAPI semantic version string, e.g., "3.0.1".
  final String openapi;

  /// General information about the API (title, description, version, contact, etc.).
  final Info info;

  /// Flattened list of API routes parsed from the `paths` section.
  ///
  /// Each entry contains the full route and its associated HTTP methods.
  final List<RouteInfo> paths;

  /// Optional list of tag names used to group API endpoints.
  ///
  /// Note: OpenAPI allows Tag Objects; this implementation keeps just the
  /// tag names for simplicity.
  final List<String>? tags;

  /// Optional list of server definitions that specify base URLs for the API.
  final List<Server>? servers;

  /// Reusable components such as schemas, parameters, responses, etc.
  final Components components;

  /// Creates an [OpenApiJSON] instance with all parsed sections.
  OpenApiJSON({
    required this.openapi,
    required this.info,
    required this.paths,
    required this.tags,
    required this.servers,
    required this.components,
  });

  /// Constructs an [OpenApiJSON] from a decoded OpenAPI JSON map.
  ///
  /// - Reads and logs the OpenAPI version.
  /// - Parses `info`, `paths`, optional `tags`, optional `servers`, and `components`.
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
