import 'dart:io';
import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates Riverpod-based state management classes for each API category.
///
/// Each generated Riverpod file:
/// - Uses `StateNotifier` for logic
/// - Defines a `StateNotifierProvider`
/// - Contains `Result<T>` fields for all API actions
/// - Provides async methods to call facade functions and update state
/// - Replaces Bloc/Event/State/Provider with a single clean Riverpod file
class RiverpodGenerator {
  final Map<String, List<RouteInfo>> groupedRoutes;
  final String mainPath;

  RiverpodGenerator({
    required this.groupedRoutes,
    required this.mainPath,
  });

  /// Generates a Riverpod file for a specific category
  void generateRiverpodForCategory(String category) {
    List<RouteInfo> categoryPaths = groupedRoutes[category]!;
    String filePath = FilePath(
      mainPath: mainPath,
      category: category,
      isMVVM: false,
    ).riverpodFilePath;

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    // Capitalized category name
    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);

    // ---------- IMPORTS ----------
    buffer.writeln("""
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/result_builder/result.dart';
import '../../../../../common/injection/injection.dart';
import '../../../domain/repository/${category}_repository.dart';
""");

    // Models imports
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();
      buffer.writeln(
          "import '../../../infrastructure/models/${actionName}_model.dart';");
    }

    // Entities imports
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();
      buffer.writeln(
          "import '../../../domain/entities/${actionName}_param.dart';");
    }

    buffer.writeln();

    // ---------- STATE CLASS ----------
    buffer.writeln("""
class ${capitalizedCategory}State {
""");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String methodName = routeName[0].toLowerCase() + routeName.substring(1);
      buffer.writeln("  final Result<${routeName}Model> ${methodName}State;");
    }

    buffer.writeln("""
  const ${capitalizedCategory}State({
""");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String methodName = routeName[0].toLowerCase() + routeName.substring(1);
      buffer.writeln("    this.${methodName}State = const Result.init(),");
    }

    buffer.writeln("""
  });

  ${capitalizedCategory}State copyWith({
""");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String methodName = routeName[0].toLowerCase() + routeName.substring(1);
      buffer.writeln("    Result<${routeName}Model>? ${methodName}State,");
    }

    buffer.writeln("""
  }) {
    return ${capitalizedCategory}State(
""");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String methodName = routeName[0].toLowerCase() + routeName.substring(1);
      buffer.writeln(
          "      ${methodName}State: ${methodName}State ?? this.${methodName}State,");
    }

    buffer.writeln("""
    );
  }
}
""");

    // ---------- NOTIFIER CLASS ----------
    buffer.writeln("""
class ${capitalizedCategory}Notifier extends StateNotifier<${capitalizedCategory}State> {
  final ${capitalizedCategory}Repository _repository;

  ${capitalizedCategory}Notifier({required ${capitalizedCategory}Repository repository}) : _repository = repository, super(const ${capitalizedCategory}State());
""");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String methodName = routeName[0].toLowerCase() + routeName.substring(1);

      buffer.writeln("""
  /// Handles [$routeName] API call
  Future<void> $methodName(${routeName}Param param) async {
    state = state.copyWith(${methodName}State: const Result.loading());

    final response = await _repository.$methodName(${methodName}Param: param);
    response.fold(
      (l) => state = state.copyWith(${methodName}State: Result.error(error: l)),
      (r) => state = state.copyWith(${methodName}State: Result.loaded(data: r)),
    );
  }
""");
    }

    buffer.writeln("""
  /// Reset all states
  void reset() {
    state = const ${capitalizedCategory}State();
  }
}
""");

    // ---------- PROVIDER ----------
    buffer.writeln("""
final ${category}Provider = StateNotifierProvider<${capitalizedCategory}Notifier, ${capitalizedCategory}State>(
  (ref) {
    final repository =getIt<${capitalizedCategory}Repository>();
    return ${capitalizedCategory}Notifier(repository: repository);
  },
);
""");

    // Write to file
    file.writeAsStringSync(buffer.toString());
  }
}
