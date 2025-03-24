import './components.dart';
import './http_method_info.dart';
import './server.dart';
import './info.dart';

class IOpenApiJSON {
  final String openapi;
  final Info info;
  final List<String>? tags;
  final List<Server>? servers;
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;

  IOpenApiJSON({
    required this.openapi,
    required this.info,
    required this.tags,
    required this.servers,
    required this.paths,
    required this.components,
  });

  factory IOpenApiJSON.fromJson(Map<String, dynamic> json) {
    return IOpenApiJSON(
      openapi: json["openapi"],
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
      components: Components.fromJson(json["components"]),
    );
  }
}
