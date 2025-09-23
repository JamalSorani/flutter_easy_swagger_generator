import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Builds parameter metadata used to generate `*Param` classes and JSON mapping.
class ParametarsGenerator {
  /// Tracks names of subclasses already generated to avoid duplicates.
  static Set<String> generatedSubClassesNames = {};

  /// Converts OpenAPI parameters and component schemas into a list of
  /// [GeneratedParameters] describing fields, constructor args, and JSON lines.
  ///
  /// - Skips header parameters (handled at runtime layer).
  /// - Resolves Dart types via [getDartType].
  /// - If a parameter references a schema, prepares nested class generation.
  static List<GeneratedParameters> generateParametars({
    required List<TParameter>? parameters,
    required Components components,
  }) {
    final List<GeneratedParameters> generateParametars = [];
    if (parameters != null) {
      for (var param in parameters) {
        if (param.inn == "header") {
          continue;
        }
        String paramName = param.name;
        DartTypeInfo dartTypeInfo = getDartType(
          schema: param.schema,
          components: components,
          isForEntities: true,
        );

        String paramType = dartTypeInfo.className;
        String paramNameWithoutDot = paramName.replaceAll('.', '');

        String variable = ClassGeneratorHelper.formatVariable(
          paramType: paramType,
          paramName: paramNameWithoutDot,
          isNullable: !param.required,
          example: param.example ?? param.schema?.defaultValue,
          format: param.format ?? param.schema?.format,
          allowEmptyValue: param.allowEmptyValue,
        );
        String constructorVariable =
            ClassGeneratorHelper.formatConstructureVariable(
          paramName: paramNameWithoutDot,
          isRequired: param.required,
        );

        final enumValues = dartTypeInfo.schema?.enumValues ?? [];
        String jsonLine = ClassGeneratorHelper.formatJsonLine(
          paramName: paramName,
          isEnum: enumValues.isNotEmpty,
          nullable: !param.required,
          isSubClass: param.schema?.ref != null,
          isDateTime: paramType.toLowerCase().contains("date"),
          isList: paramType.toLowerCase().contains("list<"),
        );
        generateParametars.add(
          GeneratedParameters(
            type: paramType,
            generatedVariable: variable,
            generatedConstructorVariable: constructorVariable,
            generatedJsonLine: GeneratedJsonLine(
              nullable: !param.required,
              generatedJsonLine: jsonLine,
            ),
            enumValues:
                !generatedSubClassesNames.contains(paramType) ? enumValues : [],
            subClassName: paramType,
            subClassParameters: !generatedSubClassesNames.contains(paramType) &&
                    param.schema?.ref != null
                ? (RequestBodyGenerator(
                    components: components,
                    isForEntities: true,
                  ).generateRequestBody(
                    content: MediaTypeContent(
                      contentType: TContentType.applicationJson,
                      schema: components.schemas[param.schema!.ref]!,
                    ),
                  ))
                : null,
          ),
        );
        generatedSubClassesNames.add(paramType);
      }
    }
    return generateParametars;
  }
}

/// Holds all generation artifacts for a single parameter field.
class GeneratedParameters {
  /// Dart type name of the field (may be a nested class name for refs).
  final String type;

  /// Full Dart field declaration string.
  final String generatedVariable;

  /// Constructor parameter snippet (with `required`/optional as needed).
  final String generatedConstructorVariable;

  /// JSON serialization line information for this field.
  final GeneratedJsonLine generatedJsonLine;

  /// Enum values (if any) for generating enum types.
  final List<String> enumValues;

  /// Subclass name to generate for referenced schemas.
  final String subClassName;

  /// Nested parameters for referenced schemas; null when not applicable.
  final List<GeneratedParameters>? subClassParameters;

  GeneratedParameters({
    required this.type,
    required this.generatedVariable,
    required this.generatedConstructorVariable,
    required this.generatedJsonLine,
    required this.enumValues,
    required this.subClassName,
    required this.subClassParameters,
  });
}

/// Represents a single line of JSON mapping along with nullability info.
class GeneratedJsonLine {
  /// True if the field is nullable in the Dart model.
  final bool nullable;

  /// The generated `toJson` mapping snippet for this field.
  final String generatedJsonLine;

  GeneratedJsonLine({
    required this.nullable,
    required this.generatedJsonLine,
  });
}
