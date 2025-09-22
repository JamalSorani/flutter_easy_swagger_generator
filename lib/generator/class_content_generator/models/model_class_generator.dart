import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class ModelClassGenerator {
  final Components components;
  final String mainPath;

  ModelClassGenerator({
    required this.components,
    required this.mainPath,
  });

  void generateClass(RouteInfo routeInfo) {
    String endPoint = 'Model';
    String routeName = getRouteName(routeInfo.fullRoute);
    String className = '$routeName$endPoint';

    String moduleName = getCategory(routeInfo.fullRoute);
    String filePath = getModelAndEntityFilePath(
      moduleName: moduleName,
      routeName: routeName,
      isForEntities: false,
      mainPath: mainPath,
    );
    List<String> contents = [];

    String classContent = _generateClassContent(
      className: className,
      content: routeInfo.httpMethodInfo.responses.response200?.content,
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
    MediaTypeContent? content,
    List<GeneratedParameters>? subClassParameters,
  }) {
    String generatedClassString = "";
    List<GeneratedParameters> generateParametars = [];
    final bool isMultiPart =
        content?.contentType == TContentType.multipartFormData;
    ParametarsGenerator.generatedSubClassesNames.clear();
    if (subClassParameters == null) {
      final requestBodyGenerator = RequestBodyGenerator(
        components: components,
        isForEntities: false,
      );

      generateParametars.addAll(
        requestBodyGenerator.generateRequestBody(
          content: content,
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
          content: content,
          subClassParameters: parameter.subClassParameters,
        );
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
      isForEntities: false,
    );

    final generatedToJsonString = classSerializerGenerator.generateFromJson(
      lines: generatedJsonLines,
      className: className,
    );

    final genereatedSubClasses =
        classSerializerGenerator.generateSubClasses(generatedSubClasses);
    String result = """${generatedImportsString}class $className {
$generatedVariablesString$generatedConstructorString$generatedToJsonString}
$genereatedSubClasses""";
    return result.trim() + LINE;
  }
}
