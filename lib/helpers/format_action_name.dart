import 'package:flutter_easy_swagger_generator/helpers/constants.dart';

String formatActionName(String path) {
  String trimmedPath =
      path.replaceAll('/api/', '').replaceAll('{', '').replaceAll('}', '');
  List<String> parts = trimmedPath.split('/');

  _removePrefix(parts);

  if (parts.length < 2) return '';

  String first = parts.removeAt(0).toLowerCase();
  StringBuffer buffer = StringBuffer(first);

  for (var part in parts) {
    buffer.write(part[0].toUpperCase());
    buffer.write(part.substring(1));
  }

  return buffer.toString();
}

List<String> _removePrefix(List<String> parts) {
  for (var prefix in prefixesToRemove) {
    if (parts.first.toLowerCase() == prefix) {
      parts.removeAt(0);
      break;
    }
  }
  return parts;
}
