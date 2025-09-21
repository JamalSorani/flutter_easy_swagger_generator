import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class ClassGenerator {
  final Components components;
  final String mainPath;

  ClassGenerator({
    required this.components,
    required this.mainPath,
  });

  void generateClass(RouteInfo routeInfo) {
    String endPoint = 'Param';
    String routeName = getRouteName(routeInfo.fullRoute);
    String className = '$routeName$endPoint';

    String moduleName = getCategory(routeInfo.fullRoute);
    String filePath = getModelAndEntityFilePath(
      moduleName,
      routeName,
      true,
      mainPath,
    );
    List<String> contents = [];

    String classContent = _generateClassContent(
      className: className,
      parameters: routeInfo.httpMethodInfo.parameters,
      requestBody: routeInfo.httpMethodInfo.requestBody,
    );
    contents.add(classContent);

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    for (var content in contents) {
      file.writeAsStringSync(content);
    }
  }

  String _generateClassContent({
    required String className,
    required List<Parameter>? parameters,
    required RequestBody? requestBody,
    List<GeneratedParameters>? subClassParameters,
  }) {
    String generatedClassString = "";
    List<GeneratedParameters> generateParametars = [];
    final bool isMultiPart =
        requestBody?.content?.contentType == TContentType.multipartFormData;
    ParametarsGenerator.generatedSubClassesNames.clear();
    if (subClassParameters == null) {
      generateParametars = ParametarsGenerator.generateParametars(
        parameters: parameters,
        components: components,
      );
      final requestBodyGenerator = RequestBodyGenerator(
        components: components,
      );

      generateParametars.addAll(
        requestBodyGenerator.generateRequestBody(
          requestBody: requestBody,
        ),
      );
    } else {
      generatedClassString = "$generatedClassString$LINE";
      generateParametars = subClassParameters;
    }
    final classSerializerGenerator = ClassSerializerGenerator(
      className: className,
      components: components,
    );

    // Generate class definition
    final List<String> generatedConstructorVariable = [];
    final List<GeneratedJsonLine> generatedJsonLines = [];
    final List<String> generatedSubClasses = [];

    String generatedImportsString = classSerializerGenerator.generateImports(
        generateParametars, isMultiPart);
    String generatedVariablesString = "";
    for (var parameter in generateParametars) {
      generatedConstructorVariable.add(parameter.generatedConstructorVariable);
      generatedJsonLines.add(parameter.generatedJsonLine);
      generatedVariablesString += (parameter.generatedVariable + LINE);

      String enumClassString = '';
      if (parameter.enumValues.isNotEmpty) {
        enumClassString = """

enum ${parameter.subClassName} {
${parameter.enumValues.map((e) => "  $e,").join(LINE)}
}""";
      }
      if (enumClassString.isNotEmpty) {
        generatedSubClasses.add(enumClassString);
      }

      String refClassString = '';
      if (parameter.subClassParameters != null &&
          parameter.enumValues.isEmpty) {
        String subClassName = parameter.subClassName;
        if (subClassName.startsWith("List")) {
          subClassName =
              subClassName.replaceAll("List<", "").replaceAll(">", "");
        }
        refClassString = _generateClassContent(
          className: subClassName,
          parameters: [],
          requestBody: null,
          subClassParameters: parameter.subClassParameters,
        );
      }
      if (refClassString.isNotEmpty) {
        final map = splitImportsAndBody(refClassString + LINE);
        final imports = map["imports"]!;
        final body = map["body"]!;
        generatedSubClasses.add(body);
        if (!generatedImportsString.contains(imports)) {
          generatedImportsString += (imports + LINE);
        }
      }
    }

    final generatedConstructorString = classSerializerGenerator
        .generateConstructor(generatedConstructorVariable);

    final generatedToJsonString = classSerializerGenerator.generateToJson(
        generatedJsonLines, isMultiPart);

    final genereatedSubClasses =
        classSerializerGenerator.generateSubClasses(generatedSubClasses);
    String result = """${generatedImportsString}class $className {
$generatedVariablesString$generatedConstructorString$generatedToJsonString}
$genereatedSubClasses""";
    return result.trim() + LINE;
  }
}

Map<String, String> splitImportsAndBody(String classString) {
  final lines = classString.split('\n');

  final importLines = <String>[];
  final bodyLines = <String>[];

  for (var line in lines) {
    if (line.trim().startsWith("import")) {
      importLines.add(line);
    } else {
      bodyLines.add(line);
    }
  }

  return {
    "imports": importLines.join('\n'),
    "body": bodyLines.join('\n'),
  };
}
