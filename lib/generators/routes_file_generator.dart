import 'dart:io';
import 'package:path/path.dart' as path;

import '../helpers/fetch_swagger_data.dart';
import '../type/route_info.dart';

void generateRouteFile({
  required String controllerDir,
  required String controllerName,
  required List<TRouteInfo> routes,
  String? getControllerFuncFromSettings,
  required String apiNameConverter,
}) {
  final filePath = path.join(
    controllerDir,
    '${convertToKebabCase(controllerName)}.api-routes.dart',
  );

  StringBuffer content = StringBuffer()
    ..write('const ${toCamelCase(controllerName)}ApiRoutes = {\n');

  final Map<String, bool> routeFlag = {};

  for (var routeInfo in routes) {
    final route = routeInfo.routes.keys.first;
    final info = routeInfo.routes[route];

    String apiName = getApiNameFromRoute(
      route,
      false,
      getControllerFuncFromSettings,
      apiNameConverter,
    );

    int i = 1;
    while (routeFlag[apiName] == true) {
      apiName = '${apiName}$i';
      i++;
    }
    routeFlag[apiName] = true;

    content.write(
        '\t$apiName: ${handleParameterInPath(route, info?.parametersInPath ?? [])},\n');
  }

  content.write('};\n\n');
  content.write('export default ${toCamelCase(controllerName)}ApiRoutes;');

  File(filePath).writeAsStringSync(content.toString());
}
