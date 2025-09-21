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
/// - Cleans the path using [cleanPath] (removes `/api/{something}/` and braces).
/// - Removes prefixes defined in [ConstantsHelper.allPrefixesToRemove].
/// - Splits remaining parts into [entity] and [action].
/// - Maps common API verbs (Get, Create, Add, etc.) to readable method names.
/// - Ensures entity names are pluralized for `GetAll`.
/// - Returns a PascalCase route name like `GetOrders`, `CreateStudent`.
///
/// If the path is empty after cleaning, it falls back to
/// [ConstantsHelper.generalCategory].
String getRouteName(String path) {
  path = cleanPath(path);
  List<String> parts = path.split('/')..removeWhere((p) => p.isEmpty);

  if (parts.isEmpty) return ConstantsHelper.generalCategory;

  // Special handling for Hub routes
  if (parts.first.toLowerCase() == 'hub' && parts.length >= 3) {
    String entity = _toPascalCase(parts[1]); // e.g., SamePageWarning
    String action = _toPascalCase(parts[2]); // e.g., CheckPage, PageLogout
    return action + entity; // => CheckPageSamePageWarning
  }

  // Remove defined prefixes
  for (var prefix in ConstantsHelper.allPrefixesToRemove) {
    if (parts.isNotEmpty && parts.first.toLowerCase() == prefix.toLowerCase()) {
      parts.removeAt(0);
      break;
    }
  }

  if (parts.isEmpty) return ConstantsHelper.generalCategory;

  String entity = _toPascalCase(parts[0]);
  String action = parts.length > 1 ? _toPascalCase(parts[1]) : "";

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

  if (mappedAction.startsWith("GetAll") && !entity.endsWith("s")) {
    entity += "s";
  }

  if (!mappedAction.contains(entity)) {
    mappedAction = mappedAction + entity;
  }

  return mappedAction;
}

/// Converts a string to PascalCase.
String _toPascalCase(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

/// Extracts the **category** (module name) from a given [path].
///
/// - If the last segment contains `.Shared.`, returns the last part.
/// - Otherwise, removes `/api/` and braces `{}`.
/// - If path starts with `/api/{something}/`, removes both `api` and `{something}`.
/// - Removes prefixes defined in [ConstantsHelper.allPrefixesToRemove].
/// - Returns the first remaining segment in lowercase.
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
  List<String> parts = path.split('/')
    ..removeWhere((p) => p.isEmpty); // remove empty strings from //

  if (parts.isEmpty) return ConstantsHelper.generalCategory;

  // If starts with api/{something}, remove both
  if (parts.length > 1 && parts.first.toLowerCase() == 'api') {
    parts.removeAt(0); // remove "api"
    parts.removeAt(0); // remove second part (e.g., "mobile", "warehouseapp")
  }

  // Remove defined prefixes
  for (var prefix in ConstantsHelper.allPrefixesToRemove) {
    if (parts.isNotEmpty && parts.first.toLowerCase() == prefix.toLowerCase()) {
      parts.removeAt(0);
      break;
    }
  }

  return parts.isNotEmpty
      ? parts.first.toLowerCase()
      : ConstantsHelper.generalCategory;
}

/// Cleans the [path] by:
/// - Removing `/api/{something}/` if it exists
/// - Removing braces `{}`
/// - Returning the remaining normalized path
String cleanPath(String path) {
  // Normalize slashes
  List<String> parts = path.split('/')
    ..removeWhere((p) => p.isEmpty); // remove empty strings from //

  if (parts.isNotEmpty && parts.first.toLowerCase() == 'api') {
    // Remove "api"
    parts.removeAt(0);

    // Remove the next segment (like mobile, warehouseapp, etc.)
    if (parts.isNotEmpty) {
      parts.removeAt(0);
    }
  }

  return parts.join('/').replaceAll('{', '').replaceAll('}', '');
}
