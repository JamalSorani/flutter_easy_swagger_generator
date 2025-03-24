import 'constants.dart';

class PathUtils {
  static String cleanPath(String path) {
    return path.replaceAll('/api/', '').replaceAll('{', '').replaceAll('}', '');
  }

  static String getCategory(String path) {
    path = cleanPath(path);
    List<String> parts = path.split('/');
    if (parts.isEmpty) return generalCategory;
    for (var prefix in prefixesToRemove) {
      if (parts.first.toLowerCase() == prefix) {
        parts.removeAt(0);
        break; // Exit after removing the prefix
      }
    }
    return parts.isNotEmpty ? parts.first.toLowerCase() : generalCategory;
  }
}
