import 'dart:io';

class ModuleInfo {
  final String name;
  ModuleInfo({required this.name});
}

class ArchitectureGenerator {
  void generateFolders(List<ModuleInfo> moduleList) {
    final folder = Directory("lib/app/");
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }

    for (var module in moduleList) {
      final moduleDirectory = Directory('lib/app/${module.name}');
      if (!moduleDirectory.existsSync()) {
        moduleDirectory.createSync();
        print('Created module directory: ${moduleDirectory.path}');
      }

      final subfolders = [
        'application',
        'domain',
        'infrastructure',
        'presentation'
      ];

      final entitiesDirectory =
          Directory('lib/app/${module.name}/domain/entities');
      if (!entitiesDirectory.existsSync()) {
        entitiesDirectory.createSync(recursive: true);
      }

      for (var subfolder in subfolders) {
        final subDirectory = Directory('lib/app/${module.name}/$subfolder');
        if (!subDirectory.existsSync()) {
          subDirectory.createSync(recursive: true);
        }
      }
    }
  }
}
