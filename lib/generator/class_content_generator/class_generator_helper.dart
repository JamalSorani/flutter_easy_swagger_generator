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
}
