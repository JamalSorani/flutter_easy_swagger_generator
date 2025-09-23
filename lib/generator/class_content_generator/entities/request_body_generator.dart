import '../../../helpers/imports.dart';

class RequestBodyGenerator {
  final Components components;
  final bool isForEntities;
  RequestBodyGenerator({required this.components, required this.isForEntities});

  List<GeneratedParameters> generateRequestBody({
    required MediaTypeContent? content,
  }) {
    if (content?.schema != null) {
      return _tPropertyGenerator(content!.schema);
    }
    return [];
  }

  //! TProperty Generator=====================================================================
  List<GeneratedParameters> _tPropertyGenerator(TProperty? tProperty) {
    if (tProperty is RefProperty) {
      // printDebug("tProperty is RefProperty ${tProperty.ref}");
      return _generateRequestBodyRef(
        ref: tProperty.ref!,
      );
    }
    if (tProperty is ObjectProperty) {
      // printDebug("tProperty is ObjectProperty");
      return _generateObjectProperty(
        tProperty,
      );
    }

    return [];
  }

  //! RefProperty Generator=====================================================================
  List<GeneratedParameters> _generateRequestBodyRef({
    required String ref,
  }) {
    final TProperty? tProperty = components.schemas[ref];
    return _tPropertyGenerator(tProperty);
  }

  //! ObjectProperty Generator=====================================================================
  List<GeneratedParameters> _generateObjectProperty(
    ObjectProperty objectProperty,
  ) {
    List<GeneratedParameters> generatedParameters = [];
    final properties = objectProperty.properties;
    for (var param in properties) {
      String paramName = param.propertyName;
      DartTypeInfo dartTypeInfo = getDartType(
        schema: param.schema,
        components: components,
        isForEntities: isForEntities,
      );
      String paramType = dartTypeInfo.className;
      String paramNameWithoutDot = paramName.replaceAll('.', '');
      String variable = ClassGeneratorHelper.formatVariable(
        paramType: paramType,
        paramName: paramNameWithoutDot,
        isNullable: param.schema.nullable,
        example: param.schema.defaultValue,
        format: param.schema.format ?? objectProperty.format,
        allowEmptyValue: false,
      );
      String constructorVariable =
          ClassGeneratorHelper.formatConstructureVariable(
        paramName: paramNameWithoutDot,
        isRequired: !param.schema.nullable,
      );
      final enumValues = dartTypeInfo.schema?.enumValues ?? [];
      final ref = param.schema.ref ??
          param.schema.items?.ref ??
          param.schema.items?.items?.ref;
      String jsonLine = isForEntities
          ? ClassGeneratorHelper.formatJsonLine(
              paramName: paramName,
              isEnum: enumValues.isNotEmpty,
              nullable: param.schema.nullable,
              isSubClass: ref != null,
              isDateTime: paramType.toLowerCase().contains("date"),
              isList: paramType.toLowerCase().contains("list<"),
            )
          : ClassGeneratorHelper.formatFromJsonLine(
              paramName: paramName,
              isEnum: enumValues.isNotEmpty,
              nullable: param.schema.nullable,
              isSubClass: ref != null,
              isDateTime: paramType.toLowerCase().contains("date"),
              isList: paramType.toLowerCase().contains("list<"),
              isListItemIsEnum: dartTypeInfo.isEnum,
              subClassName: paramType,
            );
      String fixedParamType =
          paramType.replaceAll("List<", "").replaceAll(">", "");
      generatedParameters.add(
        GeneratedParameters(
          type: paramType,
          generatedVariable: variable,
          generatedConstructorVariable: constructorVariable,
          generatedJsonLine: GeneratedJsonLine(
            nullable: param.schema.nullable,
            generatedJsonLine: jsonLine,
          ),
          enumValues: !ParametarsGenerator.generatedSubClassesNames
                  .contains(fixedParamType)
              ? enumValues
              : [],
          subClassName: paramType,
          subClassParameters: !ParametarsGenerator.generatedSubClassesNames
                      .contains(fixedParamType) &&
                  ref != null
              ? (generateRequestBody(
                  content: MediaTypeContent(
                    contentType: TContentType.applicationJson,
                    schema: components.schemas[ref]!,
                  ),
                ))
              : null,
        ),
      );
      ParametarsGenerator.generatedSubClassesNames.add(fixedParamType);
    }
    return generatedParameters;
  }
}
