import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/components.dart';
import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';
import 'package:flutter_easy_swagger_generator/helpers/converters.dart';
import '../../helpers/printer.dart';
import '../../helpers/utils.dart';

/// A generator responsible for creating Bloc files for each API category.
///
/// This class takes the parsed Swagger `paths`, `components`, and other
/// configuration values to generate:
/// - Bloc classes
/// - Bloc states
/// - Bloc events
///
/// The generated Bloc files integrate with the `Result` sealed class to
/// represent different states (loading, success, error).
class BlocGenerator {
  /// The map of API paths grouped by route and their corresponding methods.
  final Map<String, Map<String, HttpMethodInfo>> paths;

  /// The components defined in the Swagger file.
  final Components components;

  /// The list of modules to include in generation.
  final List<String> moduleList;

  /// The main base path where files will be generated.
  final String mainPath;

  /// Creates a [BlocGenerator] instance with required inputs.
  BlocGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
    required this.mainPath,
  });

  /// Generates Bloc files for all grouped API paths.
  ///
  /// Steps:
  /// 1. Group API paths by category.
  /// 2. Generate a Bloc file for each category.
  /// 3. Handle errors gracefully during generation.
  void generateBloc() {
    try {
      Map<String, List<MapEntry<String, Map<String, HttpMethodInfo>>>>
          groupedPaths = {};

      // Group paths by category
      for (var path in paths.keys) {
        String category = getCategory(path);
        if (!groupedPaths.containsKey(category)) {
          groupedPaths[category] = [];
        }
        groupedPaths[category]!.add(MapEntry(path, paths[path]!));
      }

      // Generate Bloc for each category
      for (var category in groupedPaths.keys) {
        _generateBlocForCategory(category, groupedPaths[category]!);
      }
    } catch (e) {
      printError('Error while generating Bloc: $e');
    }
  }

  /// Generates a Bloc file for a specific [category].
  ///
  /// Each category represents a group of API endpoints.
  ///
  /// - The Bloc handles events and states for each method in the category.
  /// - Uses the corresponding Facade for making API calls.
  /// - Updates states based on the `Result` type (loading, error, loaded).
  void _generateBlocForCategory(
    String category,
    List<MapEntry<String, Map<String, HttpMethodInfo>>> categoryPaths,
  ) {
    String filePath =
        '$mainPath/$category/presentation/state/${category}_bloc.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    // Import statements
    buffer.writeln("""
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/result_builder/result.dart';
import '../../application/${category}_facade.dart';""");

    // Add model imports for each route
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);

      buffer.writeln(
          "import '../../infrastructure/models/${actionName}_model.dart';");
    }

    // Add entity imports for each route
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);
      buffer
          .writeln("import '../../domain/entities/${actionName}_param.dart';");
    }

    buffer.writeln(
      """
part '${category}_event.dart';
part '${category}_state.dart';
""",
    );

    // Capitalize category name for Bloc class
    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);

    // Bloc class definition
    buffer.writeln(
      """
class ${capitalizedCategory}Bloc extends Bloc<${capitalizedCategory}Event, ${capitalizedCategory}State> {
  final ${capitalizedCategory}Facade _facade;
  ${capitalizedCategory}Bloc({required ${capitalizedCategory}Facade facade})
      : _facade = facade,
        super(${capitalizedCategory}State()) {""",
    );

    // Register event handlers
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;

      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);
        buffer.writeln(
          """
    on<${actionName}Event>(_$methodName);""",
        );
      }
    }
    buffer.writeln("  }");

    // Define event handler functions
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;

      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);
        buffer.writeln(
          """

  /// Handles the [${actionName}Event].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the facade method.
  /// 3. Emit error state on failure or loaded state on success.
  _$methodName(${actionName}Event event, Emitter emit) async{
    emit(state.copyWith(${methodName}State: const Result.loading()));
    final response = await _facade.$methodName(
        ${methodName}Param: event.${methodName}Param);
    response.fold(
      (l) => emit(state.copyWith(${methodName}State: Result.error(error: l))),
      (r) => emit(state.copyWith(${methodName}State: Result.loaded(data: r))),
    );
  }""",
        );
      }
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
