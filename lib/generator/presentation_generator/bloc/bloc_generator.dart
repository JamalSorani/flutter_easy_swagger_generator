import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

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
  final Map<String, List<RouteInfo>> groupedRoutes;

  /// The main base path where files will be generated.
  final String mainPath;

  /// Creates a [BlocGenerator] instance with required inputs.
  BlocGenerator({
    required this.groupedRoutes,
    required this.mainPath,
  });

  /// Generates a Bloc file for a specific [category].
  ///
  /// Each category represents a group of API endpoints.
  ///
  /// - The Bloc handles events and states for each method in the category.
  /// - Uses the corresponding Repository for making API calls.
  /// - Updates states based on the `Result` type (loading, error, loaded).
  void generateBlocForCategory(
    String category,
  ) {
    List<RouteInfo> categoryPaths = groupedRoutes[category]!;
    String filePath = FilePath(
      mainPath: mainPath,
      category: category,
      isMVVM: false,
    ).blocFilePath;

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    // Import statements
    buffer.writeln("""
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/result_builder/result.dart';
import '../../../domain/repository/${category}_repository.dart';""");

    // Add model imports for each route
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();

      buffer.writeln(
          "import '../../../infrastructure/models/${actionName}_model.dart';");
    }

    // Add entity imports for each route
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();
      buffer.writeln(
          "import '../../../domain/entities/${actionName}_param.dart';");
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
  final ${capitalizedCategory}Repository _repository;
  ${capitalizedCategory}Bloc({required ${capitalizedCategory}Repository repository})
      : _repository = repository,
        super(${capitalizedCategory}State()) {""",
    );

    // Register event handlers
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName;
      String actionEventName = actionName;
      if (actionEventName == capitalizedCategory) {
        actionEventName = "${actionEventName}Event";
      }

      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      buffer.writeln(
        """
    on<${actionEventName}Event>(_$methodName);""",
      );
    }
    buffer.writeln("  }");

    // Define event handler functions
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName;
      String actionEventName = actionName;
      if (actionEventName == capitalizedCategory) {
        actionEventName = "${actionEventName}Event";
      }

      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      buffer.writeln(
        """

  /// Handles the [${actionName}Event].
  ///
  /// Steps:
  /// 1. Emit loading state.
  /// 2. Call the repository method.
  /// 3. Emit error state on failure or loaded state on success.
  _$methodName(${actionEventName}Event event, Emitter emit) async{
    emit(state.copyWith(${methodName}State: const Result.loading()));
    final response = await _repository.$methodName(
        ${methodName}Param: event.${methodName}Param);
    response.fold(
      (l) => emit(state.copyWith(${methodName}State: Result.error(error: l))),
      (r) => emit(state.copyWith(${methodName}State: Result.loaded(data: r))),
    );
  }""",
      );
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
