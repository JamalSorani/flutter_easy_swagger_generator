import 'package:flutter_easy_swagger_generator/generator/class_content_generator/model_class_generator.dart';

import '../../classes/components.dart';
import '../../classes/http_method_info.dart';

/// A generator responsible for creating model classes from Swagger definitions.
///
/// The generated model classes:
/// - Represent the response structures of API endpoints.
/// - Are based on the `200` success response.
/// - Use the provided Swagger [components] for schema references.
class ModelsGenerator {
  /// The list of modules to include in generation.
  final List<String> moduleList;

  /// The map of API paths and their associated HTTP methods.
  final Map<String, Map<String, HttpMethodInfo>> paths;

  /// The components defined in the Swagger file.
  final Components components;

  /// The main base path where files will be generated.
  final String mainPath;

  /// Creates a [ModelsGenerator] instance.
  ModelsGenerator({
    required this.moduleList,
    required this.paths,
    required this.components,
    required this.mainPath,
  });

  /// Generates model classes for all API endpoints.
  ///
  /// Steps:
  /// 1. Iterates over each [path] and [method].
  /// 2. Skips endpoints without a `200` response.
  /// 3. For each valid response, generates a Dart model class
  ///    using [ModelClassGenerator].
  generateModels() {
    paths.forEach((path, methods) {
      methods.forEach((method, info) {
        // Skip if no 200 OK response defined
        if (info.responses.response200 == null) return;

        // Generate models for response content types
        if (info.responses.response200!.content != null) {
          info.responses.response200!.content!.forEach((contentType, content) {
            if (content.schema == null) return;

            // Generate model class from schema
            ModelClassGenerator(
              moduleList: moduleList,
              components: components,
              mainPath: mainPath,
            ).generateClass(
              path,
              {method: info},
            );
          });
        }
      });
    });
  }
}
