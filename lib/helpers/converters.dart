/// Converts a given [str] to camelCase format.
///
/// - Inserts underscores before capital letters.
/// - Converts the string to lowercase.
/// - Removes the first underscore if present.
/// - Converts underscores followed by a letter into the uppercase version
///   of that letter.
///
/// Example:
/// ```dart
/// convertToCamelCase("UserName"); // "userName"
/// convertToCamelCase("UserID");   // "userId"
/// ```
String convertToCamelCase(String str) {
  return str
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match[1]}')
      .toLowerCase()
      .replaceFirst('_', '')
      .replaceAllMapped(RegExp(r'_(\w)'), (match) => match[1]!.toUpperCase());
}

/// Converts a given [input] string to snake_case format.
///
/// - Inserts an underscore between lowercase and uppercase letter pairs.
/// - Converts the entire string to lowercase.
///
/// Example:
/// ```dart
/// convertToSnakeCase("userName"); // "user_name"
/// convertToSnakeCase("UserID");   // "user_id"
/// ```
String convertToSnakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
    return '${match.group(1)}_${match.group(2)?.toLowerCase()}';
  }).toLowerCase();
}
