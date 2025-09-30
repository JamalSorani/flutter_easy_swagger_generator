import 'dart:io';

import 'package:flutter_easy_swagger_generator/generator/class_content_generator/components_generator.dart';
import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates Dart model classes for API responses based on OpenAPI/Swagger specs.
///
/// This generator reads route information and content schemas to create
/// strongly-typed model classes, including handling of enums, nested
/// subclasses, imports, constructors, and JSON (de)serialization helpers.
class ModelClassGenerator {
  /// OpenAPI components providing access to schemas and references.
  final Components components;

  /// The root path where generated files should be written.
  final String mainPath;

  /// The concatenated contents of the global enums file, used to avoid
  /// regenerating enums that already exist globally.
  final String globalEnumsFileString;

  /// Creates a new [ModelClassGenerator].
  ///
  /// - [components]: OpenAPI components for schema lookup.
  /// - [mainPath]: Base output path for generated model files.
  /// - [globalEnumsFileString]: The full text of the global enums file
  ///   (used to check if an enum already exists and import it instead).
  ModelClassGenerator({
    required this.components,
    required this.mainPath,
    required this.globalEnumsFileString,
  });

  /// Generates a model class file for the given [routeInfo].
  ///
  /// Determines the class name and output file path based on the route, then
  /// produces the class contents and writes them to disk. The generated class
  /// represents the 200-response body for the route (if present).
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

  /// Builds the full Dart source for a single model class.
  ///
  /// When [subClassParameters] is provided, this method generates a nested
  /// class using those parameters, otherwise it derives parameters from the
  /// provided [content] schema. It also handles:
  /// - Resolving and importing enums (or generating inline enums when needed)
  /// - Recursively generating referenced nested classes
  /// - Creating variables, constructor, and fromJson helpers
  /// - Deduplicating imports
  ///
  /// Returns the complete Dart source string for the class and its nested
  /// subclasses, including necessary imports.
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
      final componentsGenerator = ComponentsGenerator(
        components: components,
        isForEntities: false,
      );

      generateParametars.addAll(
        componentsGenerator.generateComponents(
          content: content,
        ),
      );
    } else {
      generatedClassString = "$generatedClassString$line";
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
      generatedVariablesString += (parameter.generatedVariable + line);

      String enumClassString = '';
      if (parameter.enumValues.isNotEmpty) {
        if (globalEnumsFileString.contains(parameter.subClassName)) {
          if (!generatedImportsString.contains(enumsImport)) {
            generatedImportsString += enumsImport;
          }
        } else {
          enumClassString = """

enum ${parameter.subClassName} {
${parameter.enumValues.map((e) => "  $e,").join(line)}
}""";
        }
      }
      if (enumClassString.isNotEmpty) {
        generatedSubClasses.add(enumClassString);
      }

      String refClassString = '';
      if (parameter.subClassParameters != null &&
          parameter.enumValues.isEmpty) {
        final fixedParamType =
            parameter.subClassName.replaceAll("List<", "").replaceAll(">", "");
        if (globalEnumsFileString.contains(fixedParamType)) {
          if (!generatedImportsString.contains(enumsImport)) {
            generatedImportsString += enumsImport;
          }
        } else {
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
      }
      if (refClassString.isNotEmpty) {
        final map =
            ClassGeneratorHelper.splitImportsAndBody(refClassString + line);
        final imports = map["imports"]!;
        final body = map["body"]!;
        generatedSubClasses.add(body);
        if (!generatedImportsString.contains(imports)) {
          generatedImportsString += (imports + line);
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
    generatedImportsString =
        ClassGeneratorHelper.removeDuplicateImports(generatedImportsString);
    final genereatedSubClasses =
        classSerializerGenerator.generateSubClasses(generatedSubClasses);
    String result = """${generatedImportsString}class $className {
$generatedVariablesString$generatedConstructorString$generatedToJsonString}
$genereatedSubClasses""";
    return result.trim() + line;
  }
}
