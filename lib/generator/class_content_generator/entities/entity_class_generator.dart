import 'dart:io';

import 'package:flutter_easy_swagger_generator/generator/class_content_generator/components_generator.dart';
import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates Dart entity (parameter) classes for API endpoints.
///
/// For each route, this generator builds a `*Param` class representing
/// query/header/path parameters and (if present) request body fields.
class EntityClassGenerator {
  /// The OpenAPI reusable components (schemas, etc.).
  final Components components;

  /// Root output path where files are generated.
  final String mainPath;

  /// The full text of the global enums file, used to detect already-declared enums.
  final String globalEnumsFileString;

  /// Creates an [EntityClassGenerator] with required context.
  EntityClassGenerator({
    required this.components,
    required this.mainPath,
    required this.globalEnumsFileString,
  });

  /// Generates the `*Param` class for the given [routeInfo] and writes it to disk.
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

  /// Creates the Dart class code for an entity (`*Param`) and any nested types.
  ///
  /// - [className]: The name of the class to generate.
  /// - [parameters]: Query/header/path parameters for the route.
  /// - [requestBody]: Optional request body spec for the route.
  /// - [subClassParameters]: When provided, generates nested classes for complex refs.
  String _generateClassContent({
    required String className,
    required List<TParameter>? parameters,
    required TRequestBody? requestBody,
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
      final componentsGenerator = ComponentsGenerator(
        components: components,
        isForEntities: true,
      );

      generateParametars.addAll(
        componentsGenerator.generateComponents(
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
    generatedImportsString =
        ClassGeneratorHelper.removeDuplicateImports(generatedImportsString);
    final genereatedSubClasses =
        classSerializerGenerator.generateSubClasses(generatedSubClasses);
    String result = """${generatedImportsString}class $className {
$generatedVariablesString$generatedConstructorString$generatedToJsonString}
$genereatedSubClasses""";
    return result.trim() + LINE;
  }
}
