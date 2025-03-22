import 'components.dart';
import 'http_method_info.dart';
import 'server.dart';
import 'info.dart';

class IOpenApiJSON {
  final String openapi; // version
  final Info info;
  final List<Server>? servers;
  final Map<String, Map<String, HttpMethodInfo>>
      paths; // key is route and method type
  final Components components;

  IOpenApiJSON({
    required this.openapi,
    required this.info,
    this.servers,
    required this.paths,
    required this.components,
  });

  @override
  String toString() {
    return 'IOpenApiJSON{openapi: $openapi, info: $info, servers: $servers, paths: $paths, components: $components}';
  }
}
