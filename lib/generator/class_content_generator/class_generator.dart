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
    // Set<String> refSchemas = {};
    StringBuffer classBuffer = StringBuffer();

    // Generate content for each HTTP method
    String classContent = _generateClassContent(
      className: className,
      parameters: routeInfo.httpMethodInfo.parameters,
      requestBody: routeInfo.httpMethodInfo.requestBody,
      classBuffer: classBuffer,
    );
    contents.add(classContent);

    // Write class content to file
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    for (var content in contents) {
      file.writeAsStringSync(content);
    }
  }

  /// Generates the class content for parameters and request body.
  String _generateClassContent({
    required String className,
    required List<Parameter>? parameters,
    required RequestBody? requestBody,
    required StringBuffer classBuffer,
    List<GeneratedParameters>? subClassParameters,
  }) {
    List<GeneratedParameters> generateParametars = [];
    final bool isMultiPart =
        requestBody?.content?.contentType == TContentType.multipartFormData;

    if (subClassParameters == null) {
      // Handle parameters
      generateParametars = ParametarsGenerator.generateParametars(
        parameters: parameters,
        components: components,
      );
      // Handle request body
      final requestBodyGenerator = RequestBodyGenerator(
        components: components,
      );
      generateParametars.addAll(
        requestBodyGenerator.generateRequestBody(
          requestBody: requestBody,
        ),
      );
    } else {
      classBuffer.writeln("");
      generateParametars = subClassParameters;
    }
    final classSerializerGenerator = ClassSerializerGenerator(
      classBuffer: classBuffer,
      className: className,
      components: components,
    );

    // Generate class definition
    final List<String> generatedConstructorVariable = [];
    final List<GeneratedJsonLine> generatedJsonLines = [];
    final List<String> generatedEnumsClasses = [];

    classSerializerGenerator.generateImports(generateParametars, isMultiPart);
    classBuffer.writeln('class $className {');
    for (var parameter in generateParametars) {
      generatedConstructorVariable.add(parameter.generatedConstructorVariable);
      generatedJsonLines.add(parameter.generatedJsonLine);
      classBuffer.writeln(parameter.generatedVariable);

      String enumClass = '';
      if (parameter.enumValues.isNotEmpty) {
        enumClass = """

enum ${parameter.subClassName} {
${parameter.enumValues.map((e) => "  $e,").join("\n")}
}""";
      }
      if (enumClass.isNotEmpty) {
        generatedEnumsClasses.add(enumClass);
      }

      String refClass = '';
      if (parameter.subClassParameters.isNotEmpty) {
        refClass = _generateClassContent(
          className: parameter.subClassName,
          parameters: [],
          requestBody: null,
          classBuffer: StringBuffer(),
          subClassParameters: parameter.subClassParameters,
        );
      }
      if (refClass.isNotEmpty) {
        generatedEnumsClasses.add(refClass);
      }
    }

    classSerializerGenerator.generateConstructure(generatedConstructorVariable);

    classSerializerGenerator.genereateToJson(generatedJsonLines, isMultiPart);

    classSerializerGenerator.generateEnums(generatedEnumsClasses);
    return classBuffer.toString();
  }
}
