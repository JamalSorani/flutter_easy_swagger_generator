String toCamelCase(String str) {
  return str
      .replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match[1]}')
      .toLowerCase()
      .replaceFirst('_', '')
      .replaceAllMapped(RegExp(r'_(\w)'), (match) => match[1]!.toUpperCase());
}

String convertToKebabCase(String input) {
  String kebabCase = input
      .replaceAllMapped(
          RegExp(r'([a-z])([A-Z])'), (match) => '${match[1]}-${match[2]}')
      .replaceAllMapped(RegExp(r'([A-Z]+)'), (match) => '-${match[1]}')
      .toLowerCase();

  // Remove leading hyphen if present and replace double hyphens with single
  return (kebabCase.startsWith('-') ? kebabCase.substring(1) : kebabCase)
      .replaceAll('--', '-');
}

String convertToSnakeCase(String input) {
  return input.replaceAllMapped(RegExp(r'([a-z])([A-Z])'), (match) {
    return '${match.group(1)}_${match.group(2)?.toLowerCase()}';
  }).toLowerCase();
}

String getApiNameFromRoute(
  String route,
  bool withController,
  String Function(String, String?, bool)? getControllerNameFromRouteFn,
  String Function(String)? apiNameConverter,
) {
  if (getControllerNameFromRouteFn == null) {
    throw ArgumentError('getControllerNameFromRouteFn cannot be null');
  }

  String controller = getControllerNameFromRouteFn(route, null, false);
  int indexOfController = route.indexOf(controller);

  String result = withController
      ? route.substring(indexOfController)
      : route.substring(indexOfController + controller.length + 1);

  if (!withController && result.isEmpty) {
    result = route.substring(indexOfController);
  }

  result = result
      .replaceAll("{", "")
      .replaceAll("}", "")
      .replaceAll("/", " ")
      .split(" ")
      .map((w) => w.isNotEmpty ? w[0].toUpperCase() + w.substring(1) : "")
      .join("");

  result = fixCpapCaseMethod(result);

  if (result == "Delete") {
    result = "Remove";
  }

  if (apiNameConverter != null) {
    result = apiNameConverter(result);
  }

  return result;
}

String fixCpapCaseMethod(String s) {
  return s
      .replaceAll("-", " ")
      .split(" ")
      .map((w) => w.isNotEmpty ? w[0].toUpperCase() + w.substring(1) : "")
      .join("");
}
