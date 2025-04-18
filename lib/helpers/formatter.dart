import 'dart:io';

import 'printer.dart';

/// Formats all Dart files in the given directory and its subdirectories
void formatDirectory(String directory) {
  try {
    // Get all .dart files in the directory and subdirectories
    final dartFiles = Directory(directory)
        .listSync(recursive: true)
        .where((entity) => entity is File && entity.path.endsWith('.dart'))
        .map((entity) => entity.path)
        .toList();

    final totalFiles = dartFiles.length;
    var formattedFiles = 0;

    // Format each file
    for (var filePath in dartFiles) {
      try {
        formattedFiles++;
        printProgress('\rFormatting files: $formattedFiles/$totalFiles');
        Process.runSync('dart', ['format', filePath]);
      } catch (e) {
        printError('\nError formatting file $filePath: $e');
      }
    }
    print('\n'); // New line after progress
  } catch (e) {
    printError('Error formatting directory $directory: $e');
  }
}
