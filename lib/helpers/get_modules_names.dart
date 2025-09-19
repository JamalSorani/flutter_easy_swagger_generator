import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Extracts module names (tags) from Swagger API paths.
///
/// The function scans the provided [paths] map, where:
/// - The **key** is the API path (e.g., `/order/getAllOrders`).
/// - The **value** is another map where the key is the HTTP method
///   (e.g., `get`, `post`) and the value is [HttpMethodInfo].
///
/// Priority for extracting module names:
/// 1. If `tags` exist inside [HttpMethodInfo], they are used (in lowercase).
/// 2. If no tags are found, the module name is inferred from the path:
///    - Takes the second segment in the path (after the first `/`).
///    - Removes a leading `v1/` if present.
///    - Converts the module name to lowercase.
///
/// Returns:
/// - A list of unique module names in lowercase.
///
/// Example:
/// ```dart
/// final modules = getModuleNames(swaggerPaths);
/// // ["order", "cart", "employee"]
/// ```
List<String> getModuleNames(List<RouteInfo> paths) {
  Set<String> tags = {};

  // Try to extract tags directly from HttpMethodInfo
  for (var path in paths) {
    for (var tag in path.httpMethodInfo.tags) {
      tags.add(tag.toLowerCase());
    }
  }

  // If no tags are found, fall back to extracting from path segments
  if (tags.isEmpty) {
    for (var path in paths) {
      List<String> pathSegments = path.fullRoute.split('/');
      String moduleName =
          pathSegments.length > 1 ? pathSegments[1] : path.fullRoute;

      // Remove "v1/" prefix if present
      if (moduleName.startsWith('v1/')) {
        moduleName = moduleName.substring(3);
      }

      tags.add(moduleName.toLowerCase());
    }
  }

  return tags.toList();
}
