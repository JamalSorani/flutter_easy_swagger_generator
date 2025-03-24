import 'dart:io';

void createFolder(String path) {
  final folder = Directory(path);
  if (!folder.existsSync()) {
    folder.createSync(recursive: true);
  }
}
