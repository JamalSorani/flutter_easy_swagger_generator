import 'dart:io';

class ArchitectureGenerator {
  void generateFolders(List<String> moduleList) {
    final folder = Directory("lib/app/");
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }

    for (var module in moduleList) {
      final moduleDirectory = Directory('lib/app/$module');
      if (!moduleDirectory.existsSync()) {
        moduleDirectory.createSync();
      }

      final subfolders = [
        'application',
        'domain',
        'infrastructure',
        'presentation'
      ];

      final entitiesDirectory = Directory('lib/app/$module/domain/entities');
      if (!entitiesDirectory.existsSync()) {
        entitiesDirectory.createSync(recursive: true);
      }

      for (var subfolder in subfolders) {
        final subDirectory = Directory('lib/app/$module/$subfolder');
        if (!subDirectory.existsSync()) {
          subDirectory.createSync(recursive: true);
        }
      }
    }
  }
}
