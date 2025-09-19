import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Returns the file name for a given [moduleName] and [routeName].
///
/// - If [isForEntities] is `true`, the suffix `_param` is added.
/// - Otherwise, the suffix `_model` is added.
///
/// The [routeName] is first converted to `snake_case` format.
String _getFileName(String moduleName, String routeName, bool isForEntities) {
  String snakeCaseRoute = routeName.toSnakeCase();

  return isForEntities ? '${snakeCaseRoute}_param' : '${snakeCaseRoute}_model';
}

/// Builds the complete file path for either an entity or a model.
///
/// - [moduleName]: The module folder name (e.g., `order`, `cart`).
/// - [routeName]: The route name to be converted into a file name.
/// - [isForEntities]: Determines whether the path should point to
///   `domain/entities` (if `true`) or `infrastructure/models` (if `false`).
/// - [mainPath]: The root path where module folders are located.
///
/// Example:
/// ```dart
/// getModelAndEntityFilePath("order", "getOrder", true, "lib");
/// // Returns: lib/order/domain/entities/get_order_param.dart
/// ```
String getModelAndEntityFilePath(
    String moduleName, String routeName, bool isForEntities, String mainPath) {
  String fileName = _getFileName(moduleName, routeName, isForEntities);
  String subPath = isForEntities ? 'domain/entities' : 'infrastructure/models';
  return '$mainPath/$moduleName/$subPath/$fileName.dart';
}

/// Extracts a **route name** from the given [path].
///
/// - Removes `/api/` and braces `{}`.
/// - Removes prefixes defined in [ConstantsHelper.allPrefixesToRemove].
/// - Converts each path segment to PascalCase and concatenates them.
///
/// If the path is empty after cleaning, it falls back to
/// [ConstantsHelper.generalCategory].
String getRouteName(String path) {
  path = cleanPath(path);
  List<String> parts = path.split('/');
  if (parts.isEmpty) return ConstantsHelper.generalCategory;
  for (var prefix in ConstantsHelper.allPrefixesToRemove) {
    if (parts.first.toLowerCase() == prefix.toLowerCase()) {
      parts.removeAt(0);
      break;
    }
  }
  if (parts.isEmpty) return ConstantsHelper.generalCategory;
  String entity = parts[0]; // Example: "Order", "Student", "Subject"
  String action = parts.length > 1 ? parts[1] : "";

  // Mapping of API verbs → readable method names
  final Map<String, String> verbMap = {
    "GetAll": "GetAll",
    "GetById": "GetById",
    "Get": "Get",
    "Create": "Create",
    "Add": "Add",
    "Modify": "Modify",
    "Reset": "Reset",
    "Send": "Send",
    "Verify": "Verify",
    "Resend": "Resend",
    "Change": "Change",
    "Refresh": "Refresh",
    "LogIn": "Login",
    "LoginAsGuest": "LoginAsGuest",
  };

  String mappedAction = verbMap[action] ?? action;

  // Special handling: pluralize if "GetAll"
  if (mappedAction.startsWith("GetAll")) {
    if (!entity.endsWith("s")) {
      entity += "s"; // pluralize simple cases
    }
  }
  if (!mappedAction.contains(entity)) {
    mappedAction = mappedAction + entity;
  }

  return mappedAction;
}

/// Extracts the **category** (module name) from a given [path].
///
/// - If the last segment contains `.Shared.`, returns the last part.
/// - Otherwise, removes `/api/` and braces `{}`.
/// - Removes prefixes defined in [ConstantsHelper.allPrefixesToRemove].
/// - Returns the first segment in lowercase.
///
/// If no category is found, it falls back to
/// [ConstantsHelper.generalCategory].
String getCategory(String path) {
  final ref = path.split('/').last;
  final refParts = ref.split('.');

  if (refParts.contains('.Shared.')) {
    return refParts.last;
  }

  path = cleanPath(path);
  List<String> parts = path.split('/');
  if (parts.isEmpty) return ConstantsHelper.generalCategory;
  for (var prefix in ConstantsHelper.allPrefixesToRemove) {
    if (parts.first.toLowerCase() == prefix.toLowerCase()) {
      parts.removeAt(0);
      break;
    }
  }
  return parts.isNotEmpty
      ? parts.first.toLowerCase()
      : ConstantsHelper.generalCategory;
}

/// Cleans the given [path] by removing unwanted parts.
///
/// Specifically:
/// - Removes `/api/`.
/// - Removes `{}` placeholders.
String cleanPath(String path) {
  return path.replaceAll('/api/', '').replaceAll('{', '').replaceAll('}', '');
}
