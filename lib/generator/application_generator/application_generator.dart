import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// Generates the application layer (facade classes) for each API category.
///
/// This generator is responsible for:
/// - Grouping Swagger paths by category.
/// - Generating a facade class per category that exposes repository methods.
/// - Importing models and entities for each API route.
class ApplicationGenerator {
  /// Swagger API paths.
  final Map<String, Map<String, HttpMethodInfo>> paths;

  /// Swagger components (schemas, responses, etc.).
  final Components components;

  /// List of module names.
  final List<String> moduleList;

  /// Root path where generated files will be stored.
  final String mainPath;

  /// Constructor.
  ApplicationGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
    required this.mainPath,
  });

  /// Generates the application layer for all categories.
  void generateApplication() {
    try {
      // Group paths by category
      Map<String, List<MapEntry<String, Map<String, HttpMethodInfo>>>>
          groupedPaths = {};

      for (var path in paths.keys) {
        String category = getCategory(path);
        groupedPaths.putIfAbsent(category, () => []);
        groupedPaths[category]!.add(MapEntry(path, paths[path]!));
      }

      // Generate a facade for each category
      for (var category in groupedPaths.keys) {
        _generateApplicationForCategory(category, groupedPaths[category]!);
      }
    } catch (e) {
      printError('Error while generating application: $e');
    }
  }

  /// Generates a facade class for a single category.
  ///
  /// - [category] is the API category (e.g., `user`, `product`).
  /// - [categoryPaths] is a list of API paths belonging to this category.
  void _generateApplicationForCategory(
    String category,
    List<MapEntry<String, Map<String, HttpMethodInfo>>> categoryPaths,
  ) {
    // Determine file path for facade
    String filePath = '$mainPath/$category/application/${category}_facade.dart';
    final file = File(filePath);
    file.parent.createSync(recursive: true);

    final buffer = StringBuffer();

    // Base imports
    buffer.writeln("import 'package:either_dart/either.dart';");
    buffer
        .writeln("import '../domain/repository/${category}_repository.dart';");

    // Import models
    for (var pathEntry in categoryPaths) {
      String routeName = getRouteName(pathEntry.key);
      String actionName = convertToSnakeCase(routeName);
      buffer.writeln(
          "import '../infrastructure/models/${actionName}_model.dart';");
    }

    // Import entities (parameters)
    for (var pathEntry in categoryPaths) {
      String routeName = getRouteName(pathEntry.key);
      String actionName = convertToSnakeCase(routeName);
      buffer.writeln("import '../domain/entities/${actionName}_param.dart';");
    }

    buffer.writeln();

    // Class name (capitalized category)
    String className = category[0].toUpperCase() + category.substring(1);

    buffer.writeln("class ${className}Facade {");
    buffer.writeln("  final ${className}Repository _repository;");

    // Constructor
    buffer.writeln("""
  ${className}Facade({required ${className}Repository repository})
      : _repository = repository;
""");

    // Generate methods for each API route
    for (var pathEntry in categoryPaths) {
      String routeName = getRouteName(pathEntry.key);
      String actionName = routeName;

      for (var method in pathEntry.value.entries) {
        HttpMethodInfo info = method.value;

        // Skip if no 200 response
        if (info.responses.response200 == null) continue;

        // Method name: lowerCamelCase
        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);

        // Generate facade method
        buffer.writeln("""
  Future<Either<String, ${actionName}Model>> $methodName({
    required ${actionName}Param ${methodName}Param,
  }) =>
      _repository.$methodName(${methodName}Param: ${methodName}Param);
""");
      }
    }

    buffer.writeln("}");

    // Write facade to file
    file.writeAsStringSync(buffer.toString());
  }
}
