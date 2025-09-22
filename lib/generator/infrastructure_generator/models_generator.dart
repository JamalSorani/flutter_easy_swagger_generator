import 'package:flutter_easy_swagger_generator/generator/class_content_generator/models/model_class_generator.dart';

import '../../helpers/imports.dart';

class ModelsGenerator {
  final List<RouteInfo> routesInfo;

  final Components components;

  final String mainPath;

  ModelsGenerator({
    required this.routesInfo,
    required this.components,
    required this.mainPath,
  });

  void generateModels() {
    final classGenerator = ModelClassGenerator(
      components: components,
      mainPath: mainPath,
    );
    for (var routeInfo in routesInfo) {
      classGenerator.generateClass(routeInfo);
    }
  }
}
