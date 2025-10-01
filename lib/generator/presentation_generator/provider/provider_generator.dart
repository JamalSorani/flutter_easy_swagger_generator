import 'dart:io';
import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates Provider-based state management classes for each API category.
///
/// Each generated Provider:
/// - Uses `ChangeNotifier`
/// - Contains `Result<T>` fields for all API actions
/// - Provides async methods to call repository functions and notify listeners
/// - Replaces Bloc/Event/State trio with a single clean Provider file
class ProviderGenerator {
  final Map<String, List<RouteInfo>> groupedRoutes;
  final String mainPath;

  final bool isMVVM;

  ProviderGenerator({
    required this.groupedRoutes,
    required this.mainPath,
    required this.isMVVM,
  });

  /// Generates a Provider file for a specific category
  void generateProviderForCategory(String category) {
    List<RouteInfo> categoryPaths = groupedRoutes[category]!;
    String filePath = FilePath(
      mainPath: mainPath,
      category: category,
      isMVVM: isMVVM,
    ).providerFilePath;
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    // Category name with capital letter
    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);

    // ---------- IMPORTS ----------
    buffer.writeln("""
import 'package:flutter/foundation.dart';
import '../../../../../core/result_builder/result.dart';
${isMVVM ? "import '../data/repositories/${category}_repository.dart';" : "import '../../../domain/repository/${category}_repository.dart';"}""");

    // Models
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();
      final importPath = ImportPath(
        isMVVM: isMVVM,
        actionName: actionName,
      );
      final dots = isMVVM ? "../" : "../../../";
      buffer.writeln("import '$dots${importPath.modelFilePath}';");
    }

    // Entities
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();
      final importPath = ImportPath(
        isMVVM: isMVVM,
        actionName: actionName,
      );
      final dots = isMVVM ? "../" : "../../../";
      buffer.writeln("import '$dots${importPath.entityFilePath}';");
    }

    buffer.writeln();

    // ---------- CLASS START ----------
    final nameComplement = isMVVM ? "ViewModel" : "Provider";
    buffer.writeln("""
class $capitalizedCategory$nameComplement extends ChangeNotifier {
  final ${capitalizedCategory}Repository _repository;

  $capitalizedCategory$nameComplement({required ${capitalizedCategory}Repository repository})
      : _repository = repository;
""");

    // ---------- STATE VARIABLES ----------
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String methodName = routeName[0].toLowerCase() + routeName.substring(1);
      buffer.writeln(
          "  Result<${routeName}Model> ${methodName}State = const Result.init();");
    }

    buffer.writeln();

    // ---------- METHODS ----------
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String methodName = routeName[0].toLowerCase() + routeName.substring(1);

      buffer.writeln("""
  /// Handles [$routeName] API call
  Future<void> $methodName(${routeName}Param param) async {
    ${methodName}State = const Result.loading();
    notifyListeners();

    final response = await _repository.$methodName(${methodName}Param: param);
    response.fold(
      (l) => ${methodName}State = Result.error(error: l),
      (r) => ${methodName}State = Result.loaded(data: r),
    );

    notifyListeners();
  }
""");
    }

    // ---------- RESET METHOD ----------
    buffer.writeln("""
  /// Reset all states to initial
  void reset() {
""");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String methodName = routeName[0].toLowerCase() + routeName.substring(1);
      buffer.writeln("    ${methodName}State = const Result.init();");
    }

    buffer.writeln("""
    notifyListeners();
  }
}
""");

    // Write to file
    file.writeAsStringSync(buffer.toString());
  }
}
