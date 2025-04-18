String convertToCamelCase(String str) {
  return str
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match[1]}')
      .toLowerCase()
      .replaceFirst('_', '')
      .replaceAllMapped(RegExp(r'_(\w)'), (match) => match[1]!.toUpperCase());
}

String convertToSnakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
    return '${match.group(1)}_${match.group(2)?.toLowerCase()}';
  }).toLowerCase();
}
