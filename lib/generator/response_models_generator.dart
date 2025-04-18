import '../classes/components.dart';
import '../classes/http_method_info.dart';
import 'class_generator.dart';

class ResponseModelsGenerator {
  final List<String> moduleList;
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;

  ResponseModelsGenerator({
    required this.moduleList,
    required this.paths,
    required this.components,
  });

  generateResponseModels() {
    paths.forEach((path, methods) {
      methods.forEach((method, info) {
        // Skip if no responses
        if (info.responses.response200 == null) return;

        // Generate models for response content
        if (info.responses.response200!.content != null) {
          info.responses.response200!.content!.forEach((contentType, content) {
            if (content.schema == null) return;

            // Generate model class
            ClassGenerator(
              moduleList: moduleList,
              components: components,
              isForEntities: false,
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
