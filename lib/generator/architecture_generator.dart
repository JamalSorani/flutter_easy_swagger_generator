import 'dart:io';

class ArchitectureGenerator {
  void generateFolders(List<String> moduleList) {
    final folder = Directory("lib/app/");
    if (!folder.existsSync()) {
      folder.createSync(recursive: true);
    }

    // Create shared module directory
    final sharedDirectory = Directory('lib/app/shared');
    if (!sharedDirectory.existsSync()) {
      sharedDirectory.createSync();
    }

    // Create shared entities directory
    final sharedEntitiesDirectory = Directory('lib/app/shared/domain/entities');
    if (!sharedEntitiesDirectory.existsSync()) {
      sharedEntitiesDirectory.createSync(recursive: true);
    }

    // Create shared models directory
    final sharedModelsDirectory =
        Directory('lib/app/shared/infrastructure/models');
    if (!sharedModelsDirectory.existsSync()) {
      sharedModelsDirectory.createSync(recursive: true);
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

      // Create entities directory
      final entitiesDirectory = Directory('lib/app/$module/domain/entities');
      if (!entitiesDirectory.existsSync()) {
        entitiesDirectory.createSync(recursive: true);
      }

      // Create models directory
      final modelsDirectory =
          Directory('lib/app/$module/infrastructure/models');
      if (!modelsDirectory.existsSync()) {
        modelsDirectory.createSync(recursive: true);
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
