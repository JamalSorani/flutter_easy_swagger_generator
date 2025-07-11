import 'package:flutter_easy_swagger_generator/generator/class_content_generator/model_class_generator.dart';

import '../../classes/components.dart';
import '../../classes/http_method_info.dart';

class ModelsGenerator {
  final List<String> moduleList;
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;
  final String mainPath;
  ModelsGenerator({
    required this.moduleList,
    required this.paths,
    required this.components,
    required this.mainPath,
  });

  generateModels() {
    paths.forEach((path, methods) {
      methods.forEach((method, info) {
        // Skip if no responses
        if (info.responses.response200 == null) return;

        // Generate models for response content
        if (info.responses.response200!.content != null) {
          info.responses.response200!.content!.forEach((contentType, content) {
            if (content.schema == null) return;

            // Generate model class
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
