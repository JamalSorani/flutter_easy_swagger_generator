import '../../../helpers/imports.dart';

class RequestBodyGenerator {
  final Components components;
  RequestBodyGenerator({required this.components});

  List<GeneratedParameters> generateRequestBody({
    required RequestBody? requestBody,
  }) {
    if (requestBody?.content != null) {
      return _tPropertyGenerator(requestBody!.content!.schema);
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
        param.schema,
        components,
        true,
      );
      String paramType = dartTypeInfo.className;
      String paramNameWithoutDot = paramName.replaceAll('.', '');
      if (paramType.contains("List<ProductDtoParam>")) {
        printDebug(dartTypeInfo.schema?.items?.ref);
      }
      String variable = ClassGeneratorHelper.formatVariable(
        paramType: paramType,
        paramName: paramNameWithoutDot,
        isNullable: param.schema.nullable,
        example: param.schema.defaultValue,
        format: param.schema.format ?? objectProperty.format,
      );
      String constructorVariable =
          ClassGeneratorHelper.formatConstructureVariable(
        paramName: paramNameWithoutDot,
        isRequired: !param.schema.nullable,
      );
      final enumValues = dartTypeInfo.schema?.enumValues ?? [];
      final ref = param.schema.ref ?? param.schema.items?.ref;
      String jsonLine = ClassGeneratorHelper.formatJsonLine(
        paramName: paramName,
        isEnum: enumValues.isNotEmpty,
        nullable: param.schema.nullable,
        isSubClass: ref != null,
        isDateTime: paramType.toLowerCase().contains("date"),
        isList: paramType.toLowerCase().contains("list"),
      );

      generatedParameters.add(
        GeneratedParameters(
          type: paramType,
          generatedVariable: variable,
          generatedConstructorVariable: constructorVariable,
          generatedJsonLine: GeneratedJsonLine(
            nullable: param.schema.nullable,
            generatedJsonLine: jsonLine,
          ),
          enumValues:
              !ParametarsGenerator.generatedSubClassesNames.contains(paramType)
                  ? enumValues
                  : [],
          subClassName: paramType,
          subClassParameters: !ParametarsGenerator.generatedSubClassesNames
                      .contains(paramType) &&
                  ref != null
              ? (RequestBodyGenerator(components: components)
                  .generateRequestBody(
                  requestBody: RequestBody(
                    description: null,
                    content: MediaTypeContent(
                      contentType: TContentType.applicationJson,
                      schema: components.schemas[ref]!,
                    ),
                  ),
                ))
              : null,
        ),
      );
      ParametarsGenerator.generatedSubClassesNames.add(paramType);
    }
    return generatedParameters;
  }
}
