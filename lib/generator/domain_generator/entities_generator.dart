import '../../classes/components.dart';
import '../../classes/http_method_info.dart';
import '../class_content_generator/class_generator.dart';

/// Generates entity classes for each API path in the Swagger spec.
///
/// Each entity class represents the data structure required for sending
/// API requests (parameters and request body).
class EntitiesGenerator {
  /// List of module/category names.
  final List<String> moduleList;

  /// Map of API paths with their HTTP method info.
  final Map<String, Map<String, HttpMethodInfo>> paths;

  /// Swagger components used to resolve `$ref` references.
  final Components components;

  /// Base path where generated files should be saved.
  final String mainPath;

  /// Constructor for [EntitiesGenerator].
  EntitiesGenerator({
    required this.moduleList,
    required this.paths,
    required this.components,
    required this.mainPath,
  });

  /// Generates entity classes for all paths.
  ///
  /// Loops through each API path and uses [ClassGenerator] to create
  /// the corresponding Dart class for sending request data.
  void generateEntities() {
    paths.map(
      (key, value) {
        ClassGenerator(
          moduleList: moduleList,
          components: components,
          isForEntities: true, // Generate entity classes, not response models
          mainPath: mainPath,
        ).generateClass(key, value);
        return MapEntry(key, value);
      },
    );
  }
}
