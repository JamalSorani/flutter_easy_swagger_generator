import '../generator/architecture_generator.dart';
import '../type/http_method_info.dart';

List<ModuleInfo> getModuleNames(
    Map<String, Map<String, HttpMethodInfo>> paths) {
  Set<String> tags = {};
  paths.forEach((path, methods) {
    methods.forEach((method, httpMethodInfo) {
      if (httpMethodInfo.tags.isNotEmpty) {
        final List<String> tagList = httpMethodInfo.tags;
        for (var tag in tagList) {
          tags.add(tag.toLowerCase());
        }
      }
    });
  });
  if (tags.isEmpty) {
    for (var path in paths.keys) {
      List<String> pathSegments = path.split('/');
      String moduleName = pathSegments.length > 1 ? pathSegments[1] : path;
      if (moduleName.startsWith('v1/')) {
        moduleName = moduleName.substring(3);
      }
      tags.add(moduleName.toLowerCase());
    }
  }

  List<ModuleInfo> moduleList = [];
  for (var tag in tags) {
    moduleList.add(ModuleInfo(name: tag));
  }
  return moduleList;
}
