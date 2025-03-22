import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart' as path;

import '../swagger_in_dart/swagger.dart';
import '../type/components.dart';
import '../type/http_method_info.dart';
import '../type/parameter.dart';
import '../type/property.dart';
import '../type/open_api_json.dart';

import '../helpers/fetch_swagger_data.dart';

void openApiJsonToInterface(
  IOpenApiJSON openApiJson,
  String outputLocation,
  String? getControllerFuncFromSettings,
  List<String> includedControllers,
  List<String> excludedControllers,
  String interfaceNameConverter,
  String apiNameConverter,
  bool nullSafety,
) {
  final paths = openApiJson.paths;
  final components = openApiJson.components;

  final dtosInCommon = <String, dynamic>{}; // dtoName: interfaces
  final interfaces =
      <String, List<String>>{}; // {controllerName: controllerInterfaces[]}
  Map<String, String> schemasInterfaces = <String, String>{};

  String controllerName = '';
  bool isPostProcessing = false;

  // ----------------------------------------------------------------------
  preProcessing(
      openApiJson: openApiJson,
      outputLocation: outputLocation,
      getControllerFuncFromSettings: getControllerFuncFromSettings,
      includedControllers: includedControllers,
      excludedControllers: excludedControllers,
      interfaceNameConverter: interfaceNameConverter,
      apiNameConverter: apiNameConverter,
      nullSafety: nullSafety,
      dtosInCommon: dtosInCommon,
      components: components,
      paths: paths);

  // ----------------------------------------------------------------------

  final routeFlag = <String, bool>{};

  paths.forEach((route, obj) {
    String apiName = getApiNameFromRoute(
        route, true, getControllerFuncFromSettings, apiNameConverter);

    int i = 1;
    while (routeFlag.containsKey(apiName)) {
      apiName = '$apiName$i';
      i++;
    }
    routeFlag[apiName] = true;

    controllerName = getControllerNameFromRoute(
            route, getControllerFuncFromSettings, true) ??
        "";

    if (allowGenerateController(
      controllerName: controllerName,
      controllerNameToGenerate: '', // TODO: add controllerNameToGenerate
      excludedControllers: excludedControllers,
      includedControllers: includedControllers,
    )) {
      if (!interfaces.containsKey(controllerName)) {
        interfaces[controllerName] = [];
      }

      final data = obj.values.first;

      final queryParameters =
          data.parameters?.where((p) => p.inn == 'query').toList() ?? [];
      final pathParameters =
          data.parameters?.where((p) => p.inn == 'path').toList() ?? [];

      if (pathParameters.isNotEmpty ||
          queryParameters.isNotEmpty ||
          data.requestBody?.content != null) {
        final requestInterfaceName = 'I${apiName}Request';

        String content = 'typedef $requestInterfaceName = {\n';

        if (queryParameters.isNotEmpty) {
          content += getQueryParams(queryParameters,
              components: components,
              isPostProcessing: isPostProcessing,
              schemasInterfaces: schemasInterfaces,
              interfaceNameConverter: interfaceNameConverter,
              dtosInCommon: dtosInCommon,
              controllerName: controllerName,
              interfaces: interfaces,
              nullSafety: nullSafety);
        }

        if (pathParameters.isNotEmpty) {
          content += getPathParams(pathParameters,
              components: components,
              isPostProcessing: isPostProcessing,
              schemasInterfaces: schemasInterfaces,
              interfaceNameConverter: interfaceNameConverter,
              dtosInCommon: dtosInCommon,
              controllerName: controllerName,
              interfaces: interfaces,
              nullSafety: nullSafety);
        }

        if (data.requestBody?.content != null) {
          content += getBodyPayload(data.requestBody,
              components: components,
              isPostProcessing: isPostProcessing,
              schemasInterfaces: schemasInterfaces,
              interfaceNameConverter: interfaceNameConverter,
              dtosInCommon: dtosInCommon,
              controllerName: controllerName,
              interfaces: interfaces,
              nullSafety: nullSafety);
        }

        content += '}\n';

        interfaces[controllerName]!.add(content);
      }

      if (data.responses.response200?.content != null) {
        final responseInterfaceName = 'I${apiName}Response';

        String content = 'typedef $responseInterfaceName = ';

        final responsePayload = getResponsePayload(data.responses,
            components: components,
            isPostProcessing: isPostProcessing,
            schemasInterfaces: schemasInterfaces,
            interfaceNameConverter: interfaceNameConverter,
            dtosInCommon: dtosInCommon,
            controllerName: controllerName,
            interfaces: interfaces,
            nullSafety: nullSafety);
        content += responsePayload;

        interfaces[controllerName]!.add(content);
      }
    }
  });
  // ----------------------------------------------------------------------

  // #region postProcessing

  isPostProcessing = true;

  void printCommonInterfacesFile() {
    if (dtosInCommon.isEmpty) return;

    final fPath =
        path.join(outputLocation, 'common.interface.dart'); // updated to .dart

    String result = '';

    dtosInCommon.forEach((dto, prop) {
      result +=
          'typedef $dto = ${prop is String ? prop : getProperty(prop, false, true, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)}\n';
    });

    File(fPath).writeAsStringSync(result.replaceAll(';\n;', ';\n').trim());
  }

  void importDtosInCommonAndPrint() {
    // if (controllerNameToGenerate.isEmpty) { // TODO: add controllerNameToGenerate
    printCommonInterfacesFile();
    // }

    interfaces.forEach((cName, controllerInterfaces) {
      if (allowGenerateController(
        controllerName: cName,
        controllerNameToGenerate: '', // TODO: add controllerNameToGenerate
        excludedControllers: excludedControllers,
        includedControllers: includedControllers,
      )) {
        final filePath = path.join(outputLocation, convertToKebabCase(cName),
            '${convertToKebabCase(cName)}.interface.dart'); // updated to .dart
        String result = controllerInterfaces.join('\n\n');

        final dtosToImports = <String>[];

        dtosInCommon.keys.forEach((dto) {
          if (getFileDtos(result).any((fileDto) => fileDto.split(' ').any((el) {
                return el[0] == '(' && el[el.length - 1] == ')'
                    ? el.substring(1, el.length - 1) == dto
                    : el == dto;
              }))) {
            dtosToImports.add(dto);
          }
        });

        dtosToImports.sort((a, b) => a.length - b.length);

        // if (controllerNameToGenerate.isEmpty) { // TODO: add controllerNameToGenerate
        if (dtosToImports.isNotEmpty) {
          result =
              'import \'../common.interface.dart\';\n\n// ----------------------------------------------------------------------\n\n$result'; // updated to .dart
        }
        // } else {
        dtosInCommon.forEach((dto, prop) {
          result +=
              'typedef $dto = ${prop is String ? prop : getProperty(prop, false, true, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)}\n';
        });
        // }

        result = result.replaceAll(';\n;', ';\n');

        if (result.isNotEmpty) File(filePath).writeAsStringSync(result);
      }
    });
  }

  // REPLACING

  // #endregion

  // ----------------------------------------------------------------------

  // #region execute

  // replacingInterfacesNamesToUserInterfacesNames()

  importDtosInCommonAndPrint();

  // #endregion

  // ----------------------------------------------------------------------
}

// #region preProcessing

void preProcessing({
  required IOpenApiJSON openApiJson,
  required String outputLocation,
  required String? getControllerFuncFromSettings,
  required List<String> includedControllers,
  required List<String> excludedControllers,
  required String interfaceNameConverter,
  required String apiNameConverter,
  required bool nullSafety,
  required Map<String, dynamic> dtosInCommon,
  required Components components,
  required Map<String, Map<String, HttpMethodInfo>> paths,
}) {
  void recGetRef(dynamic property) {
    if (isRefProperty(property)) {
      final dtoName = property.$ref.replaceFirst('#/components/schemas/', '');

      if (dtosInCommon.containsKey(
          dtoNameToInterfaceName(dtoName, interfaceNameConverter))) {
        return;
      }

      dtosInCommon[dtoNameToInterfaceName(dtoName, interfaceNameConverter)] =
          property;

      final data = components.schemas[dtoName];
      recGetRef(data);
      return;
    }
    if (isObjectProperty(property)) {
      (property.properties?.values ?? []).forEach(recGetRef);
      if (property.additionalProperties != null &&
          property.additionalProperties != true) {
        if (isRefProperty(property.additionalProperties)) {
          recGetRef(property.additionalProperties);
        }
      }
      return;
    }
    if (isArrayProperty(property) && property.items != null) {
      recGetRef(property.items);
    }

    property.allOf
        ?.whereType<Map>()
        .where((element) => isRefProperty(element))
        .forEach(recGetRef);
    property.anyOf
        ?.whereType<Map>()
        .where((element) => isRefProperty(element))
        .forEach(recGetRef);
    property.oneOf
        ?.whereType<Map>()
        .where((element) => isRefProperty(element))
        .forEach(recGetRef);

    property.allOf
        ?.whereType<Map>()
        .where((element) => isObjectProperty(element))
        .forEach(recGetRef);
    property.anyOf
        ?.whereType<Map>()
        .where((element) => isObjectProperty(element))
        .forEach(recGetRef);
    property.oneOf
        ?.whereType<Map>()
        .where((element) => isObjectProperty(element))
        .forEach(recGetRef);

    property.allOf
        ?.whereType<Map>()
        .where((element) => isArrayProperty(element))
        .forEach(recGetRef);
    property.anyOf
        ?.whereType<Map>()
        .where((element) => isArrayProperty(element))
        .forEach(recGetRef);
    property.oneOf
        ?.whereType<Map>()
        .where((element) => isArrayProperty(element))
        .forEach(recGetRef);
  }

  paths.forEach((route, obj) {
    final data = obj.values.first;

    if (allowGenerateController(
      controllerName: getControllerNameFromRoute(
          route, getControllerFuncFromSettings, true),
      controllerNameToGenerate: '', // TODO: add controllerNameToGenerate
      excludedControllers: excludedControllers,
      includedControllers: includedControllers,
    )) {
      // query params properties
      data.parameters?.where((p) => p.inn == 'query').forEach((parameter) {
        if (parameter.schema != null) {
          recGetRef(parameter.schema);
        }
      });

      // request properties
      if (data.requestBody?.content != null) {
        final schema = data.requestBody?.content?.values.first.schema;
        if (schema != null) {
          recGetRef(schema);
        }
      }

      // response properties
      if (data.responses.response200?.content != null) {
        final schema = data.responses.response200?.content?.values.first.schema;

        if (schema != null) {
          recGetRef(schema);
        }
      }
    }
  });
}

// #endregion

// #region processing

String getRef(
  dynamic property,
  bool isPropertyOfArray,
  bool isFirstLevel, {
  required Components components,
  required bool isPostProcessing,
  required Map<String, String> schemasInterfaces,
  required String interfaceNameConverter,
  required Map<String, dynamic> dtosInCommon,
  required String controllerName,
  required Map<String, List<String>> interfaces,
  required bool nullSafety,
}) {
  final dtoName = property.$ref.replaceFirst('#/components/schemas/', '');
  final data = components.schemas[dtoName];

  if (isPostProcessing) {
    if (schemasInterfaces
        .containsKey(dtoNameToInterfaceName(dtoName, interfaceNameConverter))) {
      if (isFirstLevel) {
        return schemasInterfaces[
            dtoNameToInterfaceName(dtoName, interfaceNameConverter)]!;
      }
      return dtoNameToInterfaceName(dtoName, interfaceNameConverter);
    }
  } else if (dtosInCommon.containsKey(
          dtoNameToInterfaceName(dtoName, interfaceNameConverter)) ||
      schemasInterfaces.containsKey(
          dtoNameToInterfaceName(dtoName, interfaceNameConverter))) {
    return dtoNameToInterfaceName(dtoName, interfaceNameConverter);
  }

  schemasInterfaces[dtoNameToInterfaceName(dtoName, interfaceNameConverter)] =
      dtoNameToInterfaceName(dtoName, interfaceNameConverter);
  schemasInterfaces[dtoNameToInterfaceName(dtoName, interfaceNameConverter)] =
      getProperty(data, isPropertyOfArray, false,
          components: components,
          isPostProcessing: isPostProcessing,
          schemasInterfaces: schemasInterfaces,
          interfaceNameConverter: interfaceNameConverter,
          dtosInCommon: dtosInCommon,
          controllerName: controllerName,
          interfaces: interfaces,
          nullSafety: nullSafety);

  if (isPostProcessing) {
    dtosInCommon[controllerName] = schemasInterfaces[
        dtoNameToInterfaceName(dtoName, interfaceNameConverter)]!;

    if (isFirstLevel) {
      return schemasInterfaces[
          dtoNameToInterfaceName(dtoName, interfaceNameConverter)]!;
    }

    return dtoNameToInterfaceName(dtoName, interfaceNameConverter);
  }

  if (property.enumValues != null || data?.enumValues != null) {
    return getEnum(property, components: components);
  }

  interfaces[controllerName]!.add(
      'typedef ${dtoNameToInterfaceName(dtoName, interfaceNameConverter)} = ${schemasInterfaces[dtoNameToInterfaceName(dtoName, interfaceNameConverter)]};');

  return dtoNameToInterfaceName(dtoName, interfaceNameConverter);
}

// ----------------------------------------------------------------------

String getEnum(dynamic property, {required Components components}) {
  if (property.type == null && property.$ref != null) {
    final enumName = property.$ref.replaceFirst('#/components/schemas/', '');
    final data = components.schemas[enumName];

    return applyOr(data?.enumValues ?? []);
  }

  return '\'\'';
}

// ----------------------------------------------------------------------

String getObject(
  Map<String, dynamic>? properties,
  bool isPropertyOfArray,
  dynamic additionalProperties, {
  required Components components,
  required bool isPostProcessing,
  required Map<String, String> schemasInterfaces,
  required String interfaceNameConverter,
  required Map<String, dynamic> dtosInCommon,
  required String controllerName,
  required Map<String, List<String>> interfaces,
  required bool nullSafety,
}) {
  String content = '\t{\n';

  if (properties != null) {
    properties.forEach((propertyName, p) {
      content +=
          '\t"$propertyName": ${getProperty(p, false, false, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)}';
    });
  }

  if (additionalProperties != null) {
    content +=
        '\t[key: String]: ${getProperty(additionalProperties, isPropertyOfArray, false, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)}';
  }

  content += '}';

  return content;
}

// ----------------------------------------------------------------------

String getProperty(
  dynamic property,
  bool isPropertyOfArray,
  bool isFirstLevel, {
  required Components components,
  required bool isPostProcessing,
  required Map<String, String> schemasInterfaces,
  required String interfaceNameConverter,
  required Map<String, dynamic> dtosInCommon,
  required String controllerName,
  required Map<String, List<String>> interfaces,
  required bool nullSafety,
}) {
  if (property is List && property.isNotEmpty) {
    property = property[0];
  }

  if (property.enumValues != null) {
    return '${applyOr(property.enumValues.map((el) => (el is String) ? "\"$el\"" : el).toList())}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  if (isPrimitiveProperty(property)) {
    if (isNumberProperty(property)) {
      return 'num${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
    }
    return '${property.type}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  if (isArrayProperty(property)) {
    if (property.items != null) {
      return '${handleMultiItemsArrow(getProperty(property.items, true, false, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety))}[]${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
    }
    return '[]${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  if (isObjectProperty(property)) {
    return '${getObject(property.properties, isPropertyOfArray, property.additionalProperties == true ? null : property.additionalProperties, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  if (property.$ref == '#/components/schemas/System.TimeSpan') {
    return 'String${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  if (isRefProperty(property)) {
    return '${getRef(property, isPropertyOfArray, isFirstLevel, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  if (property.oneOf != null) {
    return '${applyOr(property.oneOf.map((p) => getProperty(p, true, false, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)).toList())}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  if (property.anyOf != null) {
    return '${handleMultiItemsArrow(applyOr(property.anyOf.map((p) => getProperty(p, true, false, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)).toList()))}[]${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  if (property.allOf != null) {
    return '${applyAnd(property.allOf.map((p) => getProperty(p, true, false, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)).toList())}${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  if (property.AnyValue != null) {
    return 'dynamic${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
  }

  return '\'\'${nullable(property, nullSafety)}${appendNewLine(isPropertyOfArray)}';
}

// ----------------------------------------------------------------------

String getQueryParams(List<IParameter> parameters,
    {required Components components,
    required bool isPostProcessing,
    required Map<String, String> schemasInterfaces,
    required String interfaceNameConverter,
    required Map<String, dynamic> dtosInCommon,
    required String controllerName,
    required Map<String, List<String>> interfaces,
    required bool nullSafety}) {
  String content = '\tqueryParams: {\n';

  parameters.forEach((parameter) {
    if (parameter.schema != null) {
      content +=
          '\t\t"${parameter.name}"${parameter.required == true ? '' : '?'}: ${getProperty(parameter.schema, false, true, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)}';
    }
  });

  content += '\t}\n';

  return content;
}

// ----------------------------------------------------------------------

String getPathParams(List<IParameter> parameters,
    {required Components components,
    required bool isPostProcessing,
    required Map<String, String> schemasInterfaces,
    required String interfaceNameConverter,
    required Map<String, dynamic> dtosInCommon,
    required String controllerName,
    required Map<String, List<String>> interfaces,
    required bool nullSafety}) {
  String content = '\tpathParams: [';

  parameters.forEach((parameter) {
    if (parameter.schema != null) {
      content +=
          '${parameter.name}: ${getProperty(parameter.schema, true, true, components: components, isPostProcessing: isPostProcessing, schemasInterfaces: schemasInterfaces, interfaceNameConverter: interfaceNameConverter, dtosInCommon: dtosInCommon, controllerName: controllerName, interfaces: interfaces, nullSafety: nullSafety)},';
    }
  });

  content += ']\n;';

  return content;
}

// ----------------------------------------------------------------------

String getBodyPayload(dynamic requestBody,
    {required Components components,
    required bool isPostProcessing,
    required Map<String, String> schemasInterfaces,
    required String interfaceNameConverter,
    required Map<String, dynamic> dtosInCommon,
    required String controllerName,
    required Map<String, List<String>> interfaces,
    required bool nullSafety}) {
  if (requestBody?.content == null) {
    return '\'\'';
  }

  String content = '\tbodyPayload: ';

  final data = requestBody.content.values.first;

  if (data.schema == null) {
    return '\'\'';
  }

  content += getProperty(data.schema, false, true,
      components: components,
      isPostProcessing: isPostProcessing,
      schemasInterfaces: schemasInterfaces,
      interfaceNameConverter: interfaceNameConverter,
      dtosInCommon: dtosInCommon,
      controllerName: controllerName,
      interfaces: interfaces,
      nullSafety: nullSafety);

  return content;
}

// ----------------------------------------------------------------------

String getResponsePayload(dynamic response,
    {required Components components,
    required bool isPostProcessing,
    required Map<String, String> schemasInterfaces,
    required String interfaceNameConverter,
    required Map<String, dynamic> dtosInCommon,
    required String controllerName,
    required Map<String, List<String>> interfaces,
    required bool nullSafety}) {
  if (response?['200']?.content == null) {
    return '\'\'';
  }

  final data = response['200'].content.values.first;

  if (data?.schema == null) {
    return '\'\'';
  }

  return getProperty(data.schema, false, true,
      components: components,
      isPostProcessing: isPostProcessing,
      schemasInterfaces: schemasInterfaces,
      interfaceNameConverter: interfaceNameConverter,
      dtosInCommon: dtosInCommon,
      controllerName: controllerName,
      interfaces: interfaces,
      nullSafety: nullSafety);
}

// ----------------------------------------------------------------------

// #endregion
