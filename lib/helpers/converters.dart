extension StringCasingExtension on String {
  /// Converts a PascalCase or camelCase string into camelCase
  String toCamelCase() {
    // 1. Normalize separators: convert "-" to "_"
    String input = replaceAll('-', '_');

    // 2. Insert underscore only when uppercase follows lowercase or digit
    input = input.replaceAllMapped(
      RegExp(r'(?<=[a-z0-9])([A-Z])'),
      (match) => '_${match[1]}',
    );

    // 3. Convert to lowercase
    input = input.toLowerCase();

    // 4. Remove leading underscore if any
    if (input.startsWith('_')) {
      input = input.substring(1);
    }

    // 5. Convert snake_case → camelCase
    input = input.replaceAllMapped(
      RegExp(r'_(\w)'),
      (match) => match[1]!.toUpperCase(),
    );

    return input;
  }

  /// Converts a camelCase or PascalCase string into snake_case
  String toSnakeCase() {
    return replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
      return '${match.group(1)}_${match.group(2)?.toLowerCase()}';
    }).toLowerCase();
  }
}
