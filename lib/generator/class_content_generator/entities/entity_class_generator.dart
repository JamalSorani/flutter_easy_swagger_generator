import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class EntityClassGenerator {
  final Components components;
  final String mainPath;
  final String globalEnumsFileString;

  EntityClassGenerator({
    required this.components,
    required this.mainPath,
    required this.globalEnumsFileString,
  });

  void generateClass(RouteInfo routeInfo) {
    String endPoint = 'Param';
    String routeName = getRouteName(routeInfo.fullRoute);
    String className = '$routeName$endPoint';

    String moduleName = getCategory(routeInfo.fullRoute);
    String filePath = getModelAndEntityFilePath(
      moduleName: moduleName,
      routeName: routeName,
      isForEntities: true,
      mainPath: mainPath,
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
        isForEntities: true,
      );

      generateParametars.addAll(
        requestBodyGenerator.generateRequestBody(
          content: requestBody?.content,
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
        if (globalEnumsFileString.contains(parameter.subClassName)) {
          if (!generatedImportsString.contains(ENUMS_IMPORT)) {
            generatedImportsString += ENUMS_IMPORT;
          }
        } else {
          enumClassString = """

enum ${parameter.subClassName} {
${parameter.enumValues.map((e) => "  $e,").join(LINE)}
}""";
        }
      }
      if (enumClassString.isNotEmpty) {
        generatedSubClasses.add(enumClassString);
      }

      String refClassString = '';
      if (parameter.subClassParameters != null &&
          parameter.enumValues.isEmpty) {
        if (globalEnumsFileString.contains(parameter.subClassName)) {
          if (!generatedImportsString.contains(ENUMS_IMPORT)) {
            generatedImportsString += ENUMS_IMPORT;
          }
        } else {
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
      }
      if (refClassString.isNotEmpty) {
        final map =
            ClassGeneratorHelper.splitImportsAndBody(refClassString + LINE);
        final imports = map["imports"]!;
        final body = map["body"]!;
        generatedSubClasses.add(body);
        if (!generatedImportsString.contains(imports)) {
          generatedImportsString += (imports + LINE);
        }
      }
    }

    final generatedConstructorString =
        classSerializerGenerator.generateConstructor(
      params: generatedConstructorVariable,
      isForEntities: true,
    );

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
