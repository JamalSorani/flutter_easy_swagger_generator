import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

// ----------------------------------------------------------------------

List<String> getFileDtos(String fileResult) => fileResult
    .split("\n")
    .map((el) {
      if (el.startsWith("\t[key: string]:")) {
        return el.split("\t[key: string]:")[1];
      } else {
        return el.split(RegExp(r"[:=]"))[1];
      }
    })
    .where((element) => element != null)
    .map((el) {
      return el!
          .split(";")[0]
          .replaceAll("[]", "")
          .replaceAll(" | null", "")
          .trim();
    })
    .where((el) => el != "{" && !["boolean", "number", "string"].contains(el))
    .toList();

String toCamelCase(String str) => str
    .replaceAllMapped(RegExp(r'([A-Z])'), (match) => '_${match.group(1)}')
    .toLowerCase()
    .replaceFirst(RegExp(r'^_'), '')
    .replaceAllMapped(
        RegExp(r'_./g'), (match) => match.group(0)!.substring(1).toUpperCase());

String convertToKebabCase(String input) {
  String kebabCase = input
      .replaceAllMapped(RegExp(r'([a-z])([A-Z])'),
          (match) => '${match.group(1)}-${match.group(2)}')
      .replaceAllMapped(RegExp(r'([A-Z]+)'), (match) => '-${match.group(1)}')
      .toLowerCase();

  return (kebabCase.startsWith("-") ? kebabCase.substring(1) : kebabCase)
      .replaceAll("--", "-");
}

String appendNewLine(bool isPropertyOfArray) => isPropertyOfArray ? "" : ";\n";

String nullable(dynamic property, dynamic nullSafety) =>
    property.nullable && (nullSafety == true || nullSafety.toString() == "true")
        ? " | null"
        : "";

String applyOr(List<dynamic> array) => array.join(" | ");

String applyAnd(List<dynamic> array) => array.join(" & ");

String dtoNameToInterfaceName(String dtoName, String interfaceNameConverter) {
  String result = dtoName
      .replaceAll(RegExp(r'[.`[\](),=+\s]'), "")
      .replaceAll("{", "")
      .replaceAll("}", "")
      .replaceAll("'", "")
      .replaceAll('"', "");
  // Dart doesn't have eval, need to find alternative
  return result;
}

String handleParameterInPath(String route, List<dynamic> parametersInPath) {
  if (route.contains("{")) {
    return "(${route.replaceAllMapped(RegExp(r'{[^}]*}'), (match) {
          final el = match.group(0);
          final parameter = parametersInPath.firstWhere(
              (p) => p.name == el!.substring(1, el.length - 1),
              orElse: () => null);
          return "${el}: ${parameter?.schema?.type ?? "number | string"}";
        }).replaceAll("{", "").replaceAll("}", "")}) => `${route.replaceAll("{", "\${")}`";
  }

  return "'$route'";
}

String handleParameterInPathForApi(String apiName, bool hasPathParams) {
  if (hasPathParams) {
    return "$apiName(...payload.pathParams)";
  }
  return apiName;
}

String handleParameterInQueryAndBodyForApi(
    bool hasQueryParams,
    bool hasBodyPayload,
    bool isArrayBodyPayload,
    String methodType,
    bool enableConfig) {
  String queryParams = enableConfig
      ? """
      params: {
        ...payload.queryParams,
        ...axiosConfig?.params,
      },
"""
      : """
      params: payload.queryParams
""";
  String axiosConfig = enableConfig
      ? """
      ...axiosConfig,"""
      : "";
  String bodyPayload = enableConfig
      ? """${!hasQueryParams ? """
""" : ""}      data: ${isArrayBodyPayload ? """[...payload.bodyPayload, ...(axiosConfig?.data||[])],""" : """{
        ...payload.bodyPayload,
        ...axiosConfig?.data,
      }"""}
"""
      : """
      data: payload.bodyPayload,
""";

  if (methodType == "post" || methodType == "put" || methodType == "patch") {
    if (hasQueryParams && hasBodyPayload) {
      return "payload.bodyPayload,\n\t\t{$axiosConfig$queryParams}";
    }
    if (hasQueryParams) {
      return "null,\n\t\t{$axiosConfig$queryParams}";
    }
    if (hasBodyPayload) {
      return "payload.bodyPayload,${enableConfig ? """
    axiosConfig,""" : ""}";
    }
  }
  if (hasQueryParams && hasBodyPayload) {
    return "{$axiosConfig$queryParams$bodyPayload\t\t}";
  }
  if (hasQueryParams) {
    return "${!enableConfig ? " " : ""}{$axiosConfig$queryParams\t\t}";
  }
  if (hasBodyPayload) {
    return "{$axiosConfig$bodyPayload\t\t}";
  }
  return enableConfig ? "axiosConfig," : "";
}

String handleResponseInApi(bool hasResponse, String apiName) {
  if (hasResponse) {
    return "<I${apiName}Response>";
  }
  return "";
}

String getApiNameFromRoute(String route, bool withController,
    String? getControllerNameFromRouteFn, String apiNameConverter) {
  String? controller =
      getControllerNameFromRoute(route, getControllerNameFromRouteFn, false);
  int indexOfController = route.indexOf(controller ?? "");

  String result = withController
      ? route.substring(indexOfController)
      : route.substring(indexOfController + (controller?.length ?? 0) + 1);

  if (!withController && result.isEmpty) {
    result = route.substring(indexOfController);
  }

  result = result
      .replaceAll("{", "")
      .replaceAll("}", "")
      .replaceAll("/", " ")
      .split(" ")
      .map((w) => w[0].toUpperCase() + w.substring(1))
      .join("");

  result = fixCpapCaseMethod(result);

  if (result == "Delete") {
    result = "Remove";
  }

  // Dart doesn't have eval, need to find alternative

  return result;
}

String fixCpapCaseMethod(String s) => s
    .replaceAll("-", " ")
    .split(" ")
    .map((w) => w[0].toUpperCase() + w.substring(1))
    .join("");

String? getControllerNameFromRoute(
    String route, String? funcFromSettings, bool fixCpapCase) {
  // Dart doesn't have eval, need to find alternative
  return route.split("/")[2];
}

// ----------------------------------------------------------------------

bool isPrimitiveProperty(dynamic property) {
  if (property.type == null) {
    return false;
  }

  dynamic type = property.type;

  if (type is List) type = type[0];

  List<String> primitiveTypes = ["number", "integer", "string", "boolean"];
  return primitiveTypes.contains(type);
}

bool isNumberProperty(dynamic property) {
  if (property.type == null) {
    return false;
  }

  List<String> primitiveTypes = ["number", "integer"];
  return primitiveTypes.contains(property.type);
}

bool isRefProperty(dynamic property) =>
    property.type == null && property.$ref != null;

bool isObjectProperty(dynamic property) => property.type == "object";

bool isArrayProperty(dynamic property) => property.type == "array";

dynamic readConfig(String configPath) {
  try {
    String configFile = File(path.absolute(configPath)).readAsStringSync();
    return jsonDecode(configFile);
  } catch (e) {
    print('Error reading config file: $e');
    exit(1);
  }
}

// Modify the configuration (add or update properties)
// configFile.newProperty = "New Value"; // Add a new property
// configFile.existingProperty = "Updated Value"; // Update an existing property

// Write the updated configuration back to the file
// writeConfig(configFile);

void writeConfig(String configFile) {
  try {
    File(configFile)
        .writeAsStringSync(jsonEncode(configFile, toEncodable: (dynamic item) {
      if (item is DateTime) {
        return item.toIso8601String();
      }
      return item;
    }));
  } catch (e) {
    print('Error writing to config file: $e');
    exit(1);
  }
}

bool allowGenerateController({
  String? controllerName,
  String? controllerNameToGenerate,
  List<String>? includedControllers,
  List<String>? excludedControllers,
}) {
  if (controllerNameToGenerate != null) {
    return controllerName == controllerNameToGenerate;
  }

  bool result = true;

  if (includedControllers?.isNotEmpty == true) {
    result = result && (includedControllers!.contains(controllerName) ?? false);
  }

  if (excludedControllers?.isNotEmpty == true) {
    result = result && (excludedControllers!.contains(controllerName) ?? false);
  }

  result = result && controllerName != null;

  return result;
}

Future<dynamic> fetchSwaggerJson({
  required String inputSource,
}) async {
  if (inputSource.endsWith(".js")) {
    if (inputSource.startsWith("http://") ||
        inputSource.startsWith("https://")) {
      // Fetch data from the URL
      try {
        final response = await http.get(Uri.parse(inputSource));
        if (response.statusCode != 200) {
          throw Exception('HTTP error! status: ${response.statusCode}');
        }
        final file = response.body;
        final paths = file
            .substring(file.indexOf('    "paths": {'),
                file.indexOf(',\n    "info": {'))
            .trim();

        final components = file
            .substring(file.indexOf('    "components": {'),
                file.indexOf(',\n  "customOptions": {'))
            .trim()
            .substring(0, file.trim().length - 1)
            .trim();

        return jsonDecode("""{
          ${paths},
          ${components}
        }""");
      } catch (error) {
        print("Error fetching data from URL: $error");
        throw error; // Rethrow or handle as needed
      }
    } else {
      // Read data from the JSON file
      final resolvedInputSource = path.absolute(inputSource);
      return await File(resolvedInputSource).readAsString().then((data) {
        try {
          final file = data;

          final paths = jsonDecode(file
              .substring(file.indexOf("paths"), file.indexOf("info"))
              .trim()
              .substring(file.trim().length - 1));
          final components = jsonDecode(file
              .substring(
                  file.indexOf("components"), file.indexOf("customOptions"))
              .trim()
              .substring(file.trim().length - 2));

          return {
            'paths': paths,
            'components': components,
          };
        } catch (parseError) {
          print("Error parsing JSON data: $parseError");
          throw parseError;
        }
      });
    }
  } else if (inputSource.startsWith("http://") ||
      inputSource.startsWith("https://")) {
    // Fetch data from the URL
    try {
      final response = await http.get(Uri.parse(inputSource));
      if (response.statusCode != 200) {
        throw Exception('HTTP error! status: ${response.statusCode}');
      }
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } catch (error) {
      print("Error fetching data from URL: $error");
      throw error; // Rethrow or handle as needed
    }
  } else {
    // Read data from the JSON file
    final resolvedInputSource = path.absolute(inputSource);
    return await File(resolvedInputSource).readAsString().then((data) {
      try {
        final jsonData = jsonDecode(data);
        return jsonData;
      } catch (parseError) {
        print("Error parsing JSON data: $parseError");
        throw parseError;
      }
    });
  }
}

dynamic prepareControllersRoutes({
  dynamic paths,
  String? getControllerFuncFromSettings,
  String? controllerNameToGenerate,
  List<String>? excludedControllers,
  List<String>? includedControllers,
  List<String>? reactQueryPageParam,
}) {
  Map<String, List<Map<String, dynamic>>> controllersRoutes = {};

  (paths as Map<String, dynamic>).forEach((route, methods) {
    String? controllerName = getControllerNameFromRoute(
        route,
        getControllerFuncFromSettings,
        true); // Use the first segment as controller name

    if (allowGenerateController(
      controllerName: controllerName,
      controllerNameToGenerate: controllerNameToGenerate,
      excludedControllers: excludedControllers,
      includedControllers: includedControllers,
    )) {
      var methodType = (methods as Map<String, dynamic>).keys.toList()[0];
      var data = (methods as Map<String, dynamic>).values.toList()[0];

      bool hasBodyPayload = false;
      bool isArrayBodyPayload = false;
      bool hasResponse = false;
      List<String> hasPageParamInQuery = (data['parameters'] as List<dynamic>)
              ?.where((p) =>
                  p['in'] == "query" &&
                  (reactQueryPageParam?.contains(p['name']) ?? false))
              ?.map<String>((el) => el['name'] as String)
              ?.toList() ??
          [];
      List<String> hasPageParamInBody = [];

      if (data['requestBody']?['content'] != null) {
        hasBodyPayload = (data['requestBody']['content'].values.toList()[0]
                ?['schema'] !=
            null);
        dynamic requestProperty =
            data['requestBody']['content'].values.toList()[0]?['schema'];
        isArrayBodyPayload = isArrayProperty(
            data['requestBody']['content'].values.toList()[0]?['schema']);
        hasPageParamInBody = (isObjectProperty(requestProperty) &&
                requestProperty['properties'] != null)
            ? (requestProperty['properties'] as Map<String, dynamic>)
                .keys
                .where((k) => reactQueryPageParam?.contains(k) ?? false)
                .toList()
            : [];
      }

      String mediaType = "application/json";

      if (data['responses']?[200]?['content'] != null) {
        hasResponse = (data['responses'][200]['content'].values.toList()[0]
                ?['schema'] !=
            null);
        mediaType =
            (data['responses'][200]['content'].keys.toList()[0] as String) ??
                "application/json";
      }

      var routeInfo = {
        'hasBodyPayload': hasBodyPayload,
        'isArrayBodyPayload': isArrayBodyPayload,
        'hasResponse': hasResponse,
        'hasPathParams':
            data['parameters']?.any((p) => p['in'] == "path") ?? false,
        'hasQueryParams':
            data['parameters']?.any((p) => p['in'] == "query") ?? false,
        'hasPageParamInBody': hasPageParamInBody,
        'hasPageParamInQuery': hasPageParamInQuery,
        'methodType': methodType,
        'mediaType': mediaType,
        'parametersInPath':
            data['parameters']?.where((p) => p['in'] == "path").toList() ?? [],
      };

      if (controllersRoutes.containsKey(controllerName)) {
        controllersRoutes[controllerName]!.add({route: routeInfo});
      } else if (controllerName != null) {
        controllersRoutes[controllerName] = [
          {route: routeInfo}
        ];
      }
    }
  });

  return controllersRoutes;
}

// for example 1 | 2 | 3[] should be (1 | 2 | 3)[]
String handleMultiItemsArrow(String result) {
  bool multiItems = result.split(" | ").length > 1;
  if (multiItems) return "($result)";
  return result;
}
