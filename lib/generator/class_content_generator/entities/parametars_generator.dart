import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class ParametarsGenerator {
  static Set<String> generatedSubClassesNames = {};

  static List<GeneratedParameters> generateParametars({
    required List<Parameter>? parameters,
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

        // if (dartTypeInfo.isRef) {
        //   String refClassName = _getRefClassName(param.schema!.ref!);
        //   classBuffer.writeln(
        //       'import \'${refClassName.toSnakeCase()}${isForEntities ? '_param' : '_model'}.dart\';');
        // }

        String paramType = dartTypeInfo.className;
        String paramNameWithoutDot = paramName.replaceAll('.', '');

        String variable = ClassGeneratorHelper.formatVariable(
          paramType: paramType,
          paramName: paramNameWithoutDot,
          isNullable: !param.required,
          example: param.example ?? param.schema?.defaultValue,
          format: param.format ?? param.schema?.format,
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

class GeneratedParameters {
  final String type;
  final String generatedVariable;
  final String generatedConstructorVariable;
  final GeneratedJsonLine generatedJsonLine;
  final List<String> enumValues;
  final String subClassName;
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

class GeneratedJsonLine {
  final bool nullable;
  final String generatedJsonLine;

  GeneratedJsonLine({
    required this.nullable,
    required this.generatedJsonLine,
  });
}
