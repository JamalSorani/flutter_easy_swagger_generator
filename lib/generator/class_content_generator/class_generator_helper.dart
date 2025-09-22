import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class ClassGeneratorHelper {
  static String formatVariable({
    required String paramType,
    required String paramName,
    required bool isNullable,
    required dynamic example,
    required String? format,
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

    return vairable;
  }

  static String formatConstructureVariable({
    required String paramName,
    required bool isRequired,
  }) {
    String requiredString = isRequired ? "required " : "";
    return '${requiredString}this.${paramName.toCamelCase().replaceAll("/", "")}';
  }

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

  static String formatFromJsonLine({
    required String paramName,
    required bool isEnum,
    required bool nullable,
    required bool isSubClass,
    required bool isDateTime,
    required bool isList,
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
      final isDoubleList = subClassName.split("List").length > 2;
      final variable = _getVariableName(subClassName);

      final listValue = _getListValue(
        isSubClass: isSubClass,
        subClassName: subClassName,
      );
      subClassName = subClassName.replaceAll("List<", "").replaceAll(">", "");
      final finalListValue = isDoubleList
          ? "(list as List).map((e)=>${_getListValue(
              isSubClass: isSubClass,
              subClassName: subClassName,
            )}).toList()"
          : listValue;

      if (isSubClass) {
        value = "$listString.map(($variable) => $finalListValue).toList()";
      } else {
        String toStr = subClassName.contains("String") ? ".toString()" : "";
        value =
            "$listString.map(($variable) => $finalListValue$toStr).toList()";
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

  static String _getListValue({
    required bool isSubClass,
    required String subClassName,
  }) {
    final variable = _getVariableName(subClassName);
    subClassName = subClassName.replaceAll("List<", "").replaceAll(">", "");
    return isSubClass ? "$subClassName.fromJson($variable)" : variable;
  }

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

  static String _getVariableName(String subClassName) {
    final variable = subClassName.split("List").length > 1 ? "list" : "e";
    subClassName = subClassName.replaceAll("List<", "").replaceAll(">", "");
    return variable;
  }
}
