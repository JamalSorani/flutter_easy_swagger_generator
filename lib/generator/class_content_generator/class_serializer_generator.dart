import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates serialization-related source for model/entity classes.
///
/// Responsible for producing:
/// - Class constructors
/// - `toJson()` method (supports FormData for multipart)
/// - `fromJson` factory
/// - Enum/nested subclass blocks composition
/// - Conditional imports
class ClassSerializerGenerator {
  /// Name of the target Dart class to generate helpers for.
  final String className;

  /// OpenAPI components for reference (not directly used in all methods).
  final Components components;

  /// Creates a new [ClassSerializerGenerator].
  ///
  /// - [className]: Target class name for which helpers are generated.
  /// - [components]: OpenAPI components providing schema context.
  ClassSerializerGenerator({
    required this.className,
    required this.components,
  });

  /// Generates the Dart constructor for the target class.
  ///
  /// - [params]: Constructor parameter entries (e.g., `required this.id`).
  /// - [isForEntities]: If true and params are empty, returns empty string
  ///   (entities may omit an empty constructor). Otherwise returns `ClassName();`.
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

  /// Generates the `toJson` method body.
  ///
  /// When [isMultiPart] is true, returns a `FormData` map representation and
  /// removes null values accordingly. Otherwise produces a `Map<String, dynamic>`.
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

  /// Concatenates generated enum and nested class blocks.
  ///
  /// Returns the combined source string.
  String generateSubClasses(List<String> enums) {
    final buffer = StringBuffer();
    for (int index = 0; index < enums.length; index++) {
      buffer.writeln(enums[index]);
    }
    return buffer.toString();
  }

  /// Generates necessary import statements based on parameters and multipart.
  ///
  /// Adds `dart:io` if any parameter type is `File` or `List<File>`, and adds
  /// `package:dio/dio.dart` when [isMultiPart] is true. Inserts a blank line
  /// after imports if any were added.
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

  /// Generates the `factory ClassName.fromJson(Map<String, dynamic> json)`.
  ///
  /// Writes all provided [lines] inside the constructor call, one per field.
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
