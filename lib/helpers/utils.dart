import '../classes/http_method_info.dart';
import 'constants.dart';
import 'converters.dart';
import 'format_action_name.dart';

String getFileName(String moduleName, String routeName, bool isForEntities) {
  String snakeCaseRoute = convertToSnakeCase(routeName);

  return isForEntities ? '${snakeCaseRoute}_param' : '${snakeCaseRoute}_model';
}

String getModelAndEntityFilePath(
    String moduleName, String routeName, bool isForEntities) {
  String fileName = getFileName(moduleName, routeName, isForEntities);
  String subPath = isForEntities ? 'domain/entities' : 'infrastructure/models';
  return 'lib/app/$moduleName/$subPath/$fileName.dart';
}

String getRouteName(String path) {
  path = cleanPath(path);
  List<String> parts = path.split('/');
  if (parts.isEmpty) return generalCategory;
  for (var prefix in prefixesToRemove) {
    if (parts.first.toLowerCase() == prefix) {
      parts.removeAt(0);
      break;
    }
  }
  return parts.map((e) => e[0].toUpperCase() + e.substring(1)).join('');
}

String getCategory(String path) {
  // Handle shared types
  final ref = path.split('/').last;
  final refParts = ref.split('.');

  if (refParts.contains('.Shared.')) {
    return refParts.last;
  }

  path = cleanPath(path);
  List<String> parts = path.split('/');
  if (parts.isEmpty) return generalCategory;
  for (var prefix in prefixesToRemove) {
    if (parts.first.toLowerCase() == prefix) {
      parts.removeAt(0);
      break;
    }
  }
  return parts.isNotEmpty ? parts.first.toLowerCase() : generalCategory;
}

List<String> getModuleNames(Map<String, Map<String, HttpMethodInfo>> paths) {
  Set<String> tags = {};
  paths.forEach((path, methods) {
    methods.forEach((method, httpMethodInfo) {
      if (httpMethodInfo.tags.isNotEmpty) {
        final List<String> tagList = httpMethodInfo.tags;
        for (var tag in tagList) {
          tags.add(tag.toLowerCase());
        }
      }
    });
  });
  if (tags.isEmpty) {
    for (var path in paths.keys) {
      List<String> pathSegments = path.split('/');
      String moduleName = pathSegments.length > 1 ? pathSegments[1] : path;
      if (moduleName.startsWith('v1/')) {
        moduleName = moduleName.substring(3);
      }
      tags.add(moduleName.toLowerCase());
    }
  }

  return tags.toList();
}
