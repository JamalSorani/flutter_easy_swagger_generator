import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import '../helpers/fetch_swagger_data.dart';
import '../type/route_info.dart';

// Function to generate the API file
void generateApiFile({
  required String controllerName,
  required String controllerDir,
  required List<TRouteInfo> routesInfo,
  required String? getControllerFuncFromSettings,
  required String apiNameConverter,
  required String dataFetcher,
  required bool enableConfig,
}) {
  if (dataFetcher == "axios") {
    _generateAxios(
      controllerName: controllerName,
      controllerDir: controllerDir,
      routesInfo: routesInfo,
      getControllerFuncFromSettings: getControllerFuncFromSettings,
      apiNameConverter: apiNameConverter,
      enableConfig: enableConfig,
    );
  } else {
    _generateFetch(
      controllerName: controllerName,
      controllerDir: controllerDir,
      routesInfo: routesInfo,
      getControllerFuncFromSettings: getControllerFuncFromSettings,
      apiNameConverter: apiNameConverter,
      enableConfig: enableConfig,
    );
  }
}

// Function to generate the API file using Axios
void _generateAxios({
  required String controllerName,
  required String controllerDir,
  required List<TRouteInfo> routesInfo,
  required String? getControllerFuncFromSettings,
  required String apiNameConverter,
  required bool enableConfig,
}) {
  final folderName = convertToKebabCase(controllerName);
  final filePath = path.join(
    controllerDir,
    '${convertToKebabCase(controllerName)}.api.dart',
  );

  var content = "import 'package:http/http.dart' as http;\n"
      "import 'package:dio/dio.dart';\n"
      "import '../helpers/fetch_swagger_data.dart';\n"
      "import '${toCamelCase(controllerName)}.api_routes.dart';\n";

  List<String> interfacesToImport = [];
  Map<String, bool> routeFlag = {};

  for (var routeInfo in routesInfo) {
    final route = routeInfo.routes.keys.first;
    final info = routeInfo.routes.values.first;
    var apiName = getApiNameFromRoute(
      route,
      true,
      getControllerFuncFromSettings,
      apiNameConverter,
    );

    if (apiName == null) continue;

    var i = 1;
    while (routeFlag.containsKey(apiName)) {
      apiName = '$apiName${i++}';
    }
    routeFlag[apiName] = true;

    if (info.hasQueryParams || info.hasBodyPayload || info.hasPathParams) {
      interfacesToImport.add('I${apiName}Request');
    }
    if (info.hasResponse) {
      interfacesToImport.add('I${apiName}Response');
    }
  }
  interfacesToImport.sort((a, b) => a.length - b.length);

  routeFlag = {};

  if (interfacesToImport.isNotEmpty) {
    content += "import '${folderName}.interface.dart' as i;\n";
  }

  content +=
      "// ----------------------------------------------------------------------\n\n";

  for (var routeInfo in routesInfo) {
    final route = routeInfo.routes.keys.first;
    final info = routeInfo.routes.values.first;
    var apiName = getApiNameFromRoute(
      route,
      false,
      getControllerFuncFromSettings,
      apiNameConverter,
    );
    var apiNameWithController = getApiNameFromRoute(
      route,
      true,
      getControllerFuncFromSettings,
      apiNameConverter,
    );

    if (apiName == null) continue;
    if (apiNameWithController == null) continue;

    var i = 1;
    while (routeFlag.containsKey(apiName)) {
      apiName = '$apiName${i++}';
    }
    routeFlag[apiName] = true;

    if (apiName != apiNameWithController) {
      var j = 1;
      while (routeFlag.containsKey(apiNameWithController)) {
        apiNameWithController = '$apiNameWithController${j++}';
      }
      routeFlag[apiNameWithController] = true;
    }

    content +=
        'Future<i.${handleResponseInApi(info.hasResponse, apiNameWithController)}> ${toCamelCase(apiName)}(${info.hasPathParams || info.hasQueryParams || info.hasBodyPayload ? 'i.${apiNameWithController}Request payload' : ''}) async {\n'
        '  final dio = Dio();\n'
        '  final response = await dio.${info.methodType.toString().split('.').last}(${handleParameterInPathForApi('\${toCamelCase(controllerName)}ApiRoutes.${apiName}', info.hasPathParams)}, data: payload.bodyPayload, queryParameters: payload.queryParams);\n'
        '  return response.data;\n'
        '}\n\n';
  }

  routeFlag = {};

  content +=
      "// ----------------------------------------------------------------------\n\n";

  content += 'class ${toCamelCase(controllerName)}Api {\n';

  List<String> apisToExport = [];

  for (var routeInfo in routesInfo) {
    var route = routeInfo.routes.keys.first;
    var apiName = getApiNameFromRoute(
      route,
      false,
      getControllerFuncFromSettings,
      apiNameConverter,
    );
    if (apiName == null) continue;

    var i = 1;
    while (routeFlag.containsKey(apiName)) {
      apiName = '$apiName${i++}';
    }
    routeFlag[apiName] = true;

    apisToExport.add(toCamelCase(apiName));
  }

  apisToExport.sort((a, b) => a.length - b.length);

  if (apisToExport.isNotEmpty) {
    content += '  ${apisToExport.join(',\n  ')}\n}\n\n';
  }

  content +=
      "// ----------------------------------------------------------------------\n\n";

  content += 'export default ${toCamelCase(controllerName)}Api;';

  File(filePath).writeAsStringSync(content);
}

// Function to generate the API file using Fetch
void _generateFetch({
  required String controllerName,
  required String controllerDir,
  required List<TRouteInfo> routesInfo,
  required String? getControllerFuncFromSettings,
  required String apiNameConverter,
  required bool enableConfig,
}) {
  final folderName = convertToKebabCase(controllerName);
  final filePath = path.join(
    controllerDir,
    '${convertToKebabCase(controllerName)}.api.dart',
  );

  final withHelpersFile = routesInfo.any((routeInfo) {
    final info = routeInfo.routes.values.first;
    return info.hasQueryParams;
  });

  var content = "import 'package:http/http.dart' as http;\n"
      "import '../helpers/fetch_swagger_data.dart';\n"
      "import '${toCamelCase(controllerName)}.api_routes.dart';\n";

  if (withHelpersFile) {
    content +=
        "import '../helpers/helpers.dart';\n"; // Assuming a helpers.dart file
  }

  List<String> interfacesToImport = [];
  Map<String, bool> routeFlag = {};

  for (var routeInfo in routesInfo) {
    var route = routeInfo.routes.keys.first;
    var info = routeInfo.routes[route]!;
    var apiName = getApiNameFromRoute(
      route,
      true,
      getControllerFuncFromSettings,
      apiNameConverter,
    );
    if (apiName == null) continue;

    var i = 1;
    while (routeFlag.containsKey(apiName)) {
      apiName = '$apiName${i++}';
    }
    routeFlag[apiName] = true;

    if (info.hasQueryParams || info.hasBodyPayload || info.hasPathParams) {
      interfacesToImport.add('I${apiName}Request');
    }
    if (info.hasResponse) {
      interfacesToImport.add('I${apiName}Response');
    }
  }
  interfacesToImport.sort((a, b) => a.length - b.length);
  routeFlag = {};

  if (interfacesToImport.isNotEmpty) {
    content += "import '${folderName}.interface.dart' as i;\n";
  }

  content +=
      "// ----------------------------------------------------------------------\n\n";

  for (var routeInfo in routesInfo) {
    var route = routeInfo.routes.keys.first;
    var info = routeInfo.routes[route]!;

    var apiName = getApiNameFromRoute(
      route,
      false,
      getControllerFuncFromSettings,
      apiNameConverter,
    );
    var apiNameWithController = getApiNameFromRoute(
      route,
      true,
      getControllerFuncFromSettings,
      apiNameConverter,
    );

    if (apiName == null) continue;
    if (apiNameWithController == null) continue;

    var i = 1;
    while (routeFlag.containsKey(apiName)) {
      apiName = '$apiName${i++}';
    }
    routeFlag[apiName] = true;

    if (apiName != apiNameWithController) {
      var j = 1;
      while (routeFlag.containsKey(apiNameWithController)) {
        apiNameWithController = '$apiNameWithController${j++}';
      }
      routeFlag[apiNameWithController] = true;
    }

    content +=
        'Future<i.${handleResponseInApi(info.hasResponse, apiNameWithController)}> ${toCamelCase(apiName)}(${info.hasPathParams || info.hasQueryParams || info.hasBodyPayload ? 'i.${apiNameWithController}Request payload' : ''}) async {\n'
        '  final url = \'${handleParameterInPathForApi('\${toCamelCase(controllerName)}ApiRoutes.${apiName}', info.hasPathParams)}${info.hasQueryParams ? '?${/*prepareQueryParams(payload.queryParams)*/ ''}' : ''}\';\n'
        '  final response = await http.get(Uri.parse(url));\n'
        '  if (response.statusCode == 200) {\n'
        '    return i.${handleResponseInApi(info.hasResponse, apiNameWithController)}.fromJson(jsonDecode(response.body));\n'
        '  } else {\n'
        '    throw Exception(\'Failed to load data\');\n'
        '  }\n'
        '}\n\n';
  }
  routeFlag = {};

  content +=
      "// ----------------------------------------------------------------------\n\n";

  content += 'class ${toCamelCase(controllerName)}Api {\n';

  List<String> apisToExport = [];

  for (var routeInfo in routesInfo) {
    var route = routeInfo.routes.keys.first;
    var apiName = getApiNameFromRoute(
      route,
      false,
      getControllerFuncFromSettings,
      apiNameConverter,
    );
    if (apiName == null) continue;

    var i = 1;
    while (routeFlag.containsKey(apiName)) {
      apiName = '$apiName${i++}';
    }
    routeFlag[apiName] = true;

    apisToExport.add(toCamelCase(apiName));
  }

  apisToExport.sort((a, b) => a.length - b.length);

  if (apisToExport.isNotEmpty) {
    content += '  ${apisToExport.join(',\n  ')}\n}\n\n';
  }

  content +=
      "// ----------------------------------------------------------------------\n\n";

  content += 'export default ${toCamelCase(controllerName)}Api;';

  File(filePath).writeAsStringSync(content);
}
