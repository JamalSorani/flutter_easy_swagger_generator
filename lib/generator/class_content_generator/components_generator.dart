import '../../../helpers/imports.dart';

/// A generator class that handles the creation of components parameters
/// from OpenAPI/Swagger specifications.
///
/// This class is responsible for processing components schemas and generating
/// the corresponding Dart code for components parameters, including nested objects
/// and references to other schemas.
class ComponentsGenerator {
  /// The OpenAPI components that contain schemas and references.
  final Components components;

  /// Flag indicating whether the generator is being used for entity classes.
  final bool isForEntities;

  /// Creates a new [ComponentsGenerator] instance.
  ///
  /// - [components]: The OpenAPI components containing schemas and references.
  /// - [isForEntities]: Whether the generator is being used for entity classes.
  ComponentsGenerator({required this.components, required this.isForEntities});

  /// Generates components parameters from the provided content.
  ///
  /// - [content]: The media type content containing the components schema.
  ///
  /// Returns a list of [GeneratedParameters] representing the components fields.
  List<GeneratedParameters> generateComponents({
    required MediaTypeContent? content,
  }) {
    if (content?.schema != null) {
      return _tPropertyGenerator(content!.schema);
    }
    return [];
  }

  /// Processes a [TProperty] and generates the corresponding parameters.
  ///
  /// This is a helper method that routes the property to the appropriate
  /// generator method based on its type.
  ///
  /// - [tProperty]: The property to process.
  ///
  /// Returns a list of [GeneratedParameters] for the given property.
  List<GeneratedParameters> _tPropertyGenerator(TProperty? tProperty) {
    if (tProperty is RefProperty) {
      // printDebug("tProperty is RefProperty ${tProperty.ref}");
      return _generateRef(
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

  /// Generates parameters for a referenced schema.
  ///
  /// This method resolves schema references and processes the referenced schema.
  ///
  /// - [ref]: The reference string pointing to a schema in the components.
  ///
  /// Returns a list of [GeneratedParameters] for the referenced schema.
  List<GeneratedParameters> _generateRef({
    required String ref,
  }) {
    final TProperty? tProperty = components.schemas[ref];
    return _tPropertyGenerator(tProperty);
  }

  /// Generates parameters for an object property.
  ///
  /// This method processes an [ObjectProperty] and generates the corresponding
  /// Dart code for all its properties, handling nested objects and references.
  ///
  /// - [objectProperty]: The object property to process.
  ///
  /// Returns a list of [GeneratedParameters] for all properties of the object.
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
              ? (generateComponents(
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
