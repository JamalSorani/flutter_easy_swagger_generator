import 'dart:developer';
import 'dart:io';

import '../type/http_method_info.dart';

class ModuleInfo {
  final String name;
  ModuleInfo({required this.name});
}

class FolderGenerator {
  final Map<String, Map<String, HttpMethodInfo>> paths;
  FolderGenerator({required this.paths});

  List<ModuleInfo> getModuleNames() {
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

  void generateFolders(List<ModuleInfo> moduleList) {
    final folder = Directory("lib/app/");
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }

    for (var module in moduleList) {
      final moduleDirectory = Directory('lib/app/${module.name}');
      if (!moduleDirectory.existsSync()) {
        moduleDirectory.createSync();
        log('Created module directory: ${moduleDirectory.path}');
      }

      final subfolders = [
        'application',
        'domain',
        'infrastructure',
        'presentation'
      ];
      for (var subfolder in subfolders) {
        final subDirectory = Directory('lib/app/${module.name}/$subfolder');
        if (!subDirectory.existsSync()) {
          subDirectory.createSync(recursive: true);
          log('Created subfolder: ${subDirectory.path}');
        }
      }
    }
  }
}
