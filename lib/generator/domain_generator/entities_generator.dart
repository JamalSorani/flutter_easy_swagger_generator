import '../../classes/components.dart';
import '../../classes/http_method_info.dart';
import '../class_content_generator/class_generator.dart';

class EntitiesGenerator {
  final List<String> moduleList;
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;
  final String mainPath;
  EntitiesGenerator({
    required this.moduleList,
    required this.paths,
    required this.components,
    required this.mainPath,
  });

  generateEntities() {
    paths.map(
      (key, value) {
        ClassGenerator(
          moduleList: moduleList,
          components: components,
          isForEntities: true,
          mainPath: mainPath,
        ).generateClass(key, value);
        return MapEntry(key, value);
      },
    );
  }
}
