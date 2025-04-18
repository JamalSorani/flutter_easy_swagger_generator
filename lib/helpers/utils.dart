import 'constants.dart';
import 'converters.dart';

String _getFileName(String moduleName, String routeName, bool isForEntities) {
  String snakeCaseRoute = convertToSnakeCase(routeName);

  return isForEntities ? '${snakeCaseRoute}_param' : '${snakeCaseRoute}_model';
}

String getModelAndEntityFilePath(
    String moduleName, String routeName, bool isForEntities) {
  String fileName = _getFileName(moduleName, routeName, isForEntities);
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

String cleanPath(String path) {
  return path.replaceAll('/api/', '').replaceAll('{', '').replaceAll('}', '');
}
