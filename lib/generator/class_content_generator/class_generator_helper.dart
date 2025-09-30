import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Utility helpers for generating Dart class source from OpenAPI schemas.
///
/// Provides string-formatting utilities to render:
/// - Field declarations
/// - Constructor parameter entries
/// - JSON serialization and deserialization lines
/// - Import/body splitting
/// - Misc helpers for nested list handling and import deduplication
class ClassGeneratorHelper {
  /// Formats a Dart `final` field declaration line.
  ///
  /// - [paramType]: Dart type name (e.g., `String`, `int`, `List<User>`).
  /// - [paramName]: Original schema/property name (will be camelCased).
  /// - [isNullable]: Whether the field is nullable.
  /// - [example]: Optional example value appended as a comment.
  /// - [format]: Optional OpenAPI `format`, appended as a comment.
  /// - [allowEmptyValue]: Appends a comment indicating empty values are allowed.
  static String formatVariable({
    required String paramType,
    required String paramName,
    required bool isNullable,
    required dynamic example,
    required String? format,
    required bool allowEmptyValue,
  }) {
    String nullAbleMark = isNullable && paramType != "dynamic" ? "?" : "";
    String vairable =
        '  final $paramType$nullAbleMark ${paramName.toCamelCase().replaceAll("/", "")};';
    if (example != null) {
      vairable = "$vairable /*Example: ${example.toString()}*/";
    }
    if (format != null) {
      vairable = "$vairable //!Format: ${format.toString()}";
    }
    if (allowEmptyValue) {
      vairable = "$vairable //! This field accept empty value";
    }

    return vairable;
  }

  /// Formats a constructor parameter entry like `required this.foo` or `this.foo`.
  ///
  /// - [paramName]: Property/field name (will be camelCased).
  /// - [isRequired]: Whether the parameter is marked as `required`.
  static String formatConstructureVariable({
    required String paramName,
    required bool isRequired,
  }) {
    String requiredString = isRequired ? "required " : "";
    return '${requiredString}this.${paramName.toCamelCase().replaceAll("/", "")}';
  }

  /// Formats a single `toJson` map entry line for a property.
  ///
  /// Handles enums (`.name`), nested objects (`toJson()`), DateTime
  /// (`toIso8601String()`), and lists of nested objects.
  ///
  /// Returns a line like: `'foo': bar?.toJson(),`
  static String formatJsonLine({
    required String paramName,
    required bool isEnum,
    required bool nullable,
    required bool isSubClass,
    required bool isDateTime,
    required bool isList,
  }) {
    String camelCaseName = paramName.replaceAll('.', '').toCamelCase();
    String nullableMark = nullable ? "?" : "";
    String enumName = isEnum ? "$nullableMark.name" : "";
    String subClassToJson =
        isSubClass && !isEnum && !isList ? "$nullableMark.toJson()" : "";
    String dateToIso8601String =
        isDateTime ? "$nullableMark.toIso8601String()" : "";
    String listToJson = isList && isSubClass
        ? "$nullableMark.map((e) => e.toJson()).toList()"
        : "";
    return '      \'$paramName\': $camelCaseName$enumName$subClassToJson$dateToIso8601String$listToJson,';
  }

  /// Formats a single `fromJson` named argument line for a property.
  ///
  /// Handles enums (by `.name`), nested objects (via `fromJson`), lists
  /// (including double-nested lists), and `DateTime.parse` for date values.
  ///
  /// Returns a line like: `foo: Foo.fromJson(json['foo']),`
  static String formatFromJsonLine({
    required String paramName,
    required bool isEnum,
    required bool nullable,
    required bool isSubClass,
    required bool isDateTime,
    required bool isList,
    required bool isListItemIsEnum,
    required String subClassName,
  }) {
    String camelCaseName = paramName.replaceAll('.', '').toCamelCase();
    String value = "json['$paramName']";
    String nullableMark = nullable ? "?" : "";
    if (isEnum) {
      value = """$subClassName.values.firstWhere(
        (e) => e.name == json['$paramName'],
        orElse: () => $subClassName.values.first,
      )""";
    }
    if (isSubClass && !isEnum && !isList) {
      value = "$subClassName.fromJson($value)";
    }
    if (isList) {
      final listString = "($value as List$nullableMark)$nullableMark";
      final isDoubleList = subClassName.split("List<").length > 2;
      final variable = _getVariableName(subClassName);

      final listValue = _getListValue(
        isSubClass: isSubClass,
        subClassName: subClassName,
        isEnum: isListItemIsEnum,
      );
      subClassName = subClassName.replaceAll("List<", "").replaceAll(">", "");
      final finalListValue = isDoubleList
          ? "(list as List).map((e)=>${_getListValue(
              isSubClass: isSubClass,
              subClassName: subClassName,
              isEnum: isListItemIsEnum,
            )}).toList()"
          : listValue;

      if (isSubClass) {
        value = "$listString.map(($variable) => $finalListValue).toList()";
      } else {
        String toStr = subClassName.contains("String") ? ".toString()" : "";
        String toInt = subClassName.contains("int") ? ".toInt()" : "";
        String toDouble = subClassName.contains("double") ? ".toDouble()" : "";
        value =
            "$listString.map(($variable) => $finalListValue$toStr$toInt$toDouble).toList()";
      }
    }
    if (isDateTime) {
      if (nullable) {
        value = """$value != null
          ? DateTime.parse($value)
          : null""";
      } else {
        value = """DateTime.parse($value)""";
      }
    }
    return '      $camelCaseName: $value,';
  }

  /// Returns the mapped expression for a list element while deserializing.
  ///
  /// If [isSubClass] is true, returns either enum resolution or `fromJson` call;
  /// otherwise returns the variable name directly.
  static String _getListValue({
    required bool isSubClass,
    required String subClassName,
    required bool isEnum,
  }) {
    final variable = _getVariableName(subClassName);
    subClassName = subClassName.replaceAll("List<", "").replaceAll(">", "");
    return isSubClass
        ? (isEnum
            ? "$subClassName.values.firstWhere((e) => e == $variable)"
            : "$subClassName.fromJson($variable)")
        : variable;
  }

  /// Splits a class source string into its import lines and body lines.
  ///
  /// Useful when composing nested class strings so imports can be deduplicated
  /// and moved to the top while appending bodies below.
  static Map<String, String> splitImportsAndBody(String classString) {
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

  /// Chooses a loop variable name based on list nesting depth.
  ///
  /// Returns `list` for double-nested lists, else `e`.
  static String _getVariableName(String subClassName) {
    final variable = subClassName.split("List<").length > 2 ? "list" : "e";
    subClassName = subClassName.replaceAll("List<", "").replaceAll(">", "");
    return variable;
  }

  /// Removes duplicate `import` lines from a composed imports string.
  ///
  /// Preserves order of first occurrence and removes blank lines.
  static String removeDuplicateImports(String imports) {
    // Split by new lines
    final lines = imports.split('\n');

    // Use a Set to keep only unique lines
    final seen = <String>{};
    final uniqueLines = <String>[];

    for (var line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue; // Skip empty lines
      if (seen.add(trimmed)) {
        uniqueLines.add(trimmed);
      }
    }

    // Join back into a single string with new lines
    return uniqueLines.join(line) + line;
  }
}
