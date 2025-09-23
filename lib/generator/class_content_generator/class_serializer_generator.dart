import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class ClassSerializerGenerator {
  final String className;
  final Components components;

  ClassSerializerGenerator({
    required this.className,
    required this.components,
  });

  //! Constructor Generator=====================================================================
  String generateConstructor({
    required List<String> params,
    required bool isForEntities,
  }) {
    bool isEmpty = params.isEmpty;
    if (isEmpty) {
      if (isForEntities) return "";
      return "  $className();$LINE";
    }

    final buffer = StringBuffer();
    buffer.writeln("");
    buffer.writeln('  $className({');
    for (var element in params) {
      buffer.writeln('    $element,');
    }
    buffer.writeln('  });');
    buffer.writeln("");
    return buffer.toString();
  }

  //! ToJson Generator=====================================================================
  String generateToJson(List<GeneratedJsonLine> lines, bool isMultiPart) {
    final buffer = StringBuffer();

    buffer.writeln(
      '''
  ${isMultiPart ? "FormData" : "Map<String, dynamic>"} toJson() {
    return ${isMultiPart ? "FormData.fromMap(" : ""}{''',
    );

    bool containsNull = false;
    for (var line in lines) {
      buffer.writeln(line.generatedJsonLine);
      containsNull = containsNull || line.nullable;
    }

    String removeNullValues = (isMultiPart || containsNull)
        ? "..removeWhere((key, value) => value == null)"
        : "";

    buffer.writeln('''
    }$removeNullValues${isMultiPart ? ")" : ""};
  }''');

    return buffer.toString();
  }

  //! SubClasses Generator=====================================================================
  String generateSubClasses(List<String> enums) {
    final buffer = StringBuffer();
    for (int index = 0; index < enums.length; index++) {
      buffer.writeln(enums[index]);
    }
    return buffer.toString();
  }

  //! Imports Generator=====================================================================
  String generateImports(
      List<GeneratedParameters> generateParametars, bool isMultiPart) {
    final buffer = StringBuffer();
    bool addEmptyLine = false;

    if (generateParametars.any((element) =>
        element.type == "File" || element.type.contains("<File>"))) {
      buffer.writeln("import 'dart:io';");
      addEmptyLine = true;
    }

    if (isMultiPart) {
      buffer.writeln("import 'package:dio/dio.dart';");
      addEmptyLine = true;
    }

    if (addEmptyLine) {
      buffer.writeln("");
    }

    return buffer.toString();
  }

  //! FromJson Generator=====================================================================
  String generateFromJson({
    required List<GeneratedJsonLine> lines,
    required String className,
  }) {
    final buffer = StringBuffer();

    buffer.writeln(
      '''
  factory $className.fromJson(Map<String, dynamic> json) {
    return $className(''',
    );
    for (var line in lines) {
      buffer.writeln(line.generatedJsonLine);
    }
    buffer.writeln('''
    );
  }''');

    return buffer.toString();
  }
}
