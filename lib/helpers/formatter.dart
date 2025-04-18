import 'dart:io';
import 'package:flutter_easy_swagger_generator/helpers/printer.dart';

/// Number of concurrent formatting operations
const int _concurrentOperations = 5;

/// Formats a single file
Future<void> _formatFile(String filePath) async {
  try {
    await Process.run('dart', ['format', filePath]);
  } catch (e) {
    printError('\nError formatting file $filePath: $e');
  }
}

/// Formats all Dart files in the given directory and its subdirectories using parallel processing
Future<void> formatDirectory(String directory) async {
  try {
    // Get all .dart files in the directory and subdirectories
    final dartFiles = Directory(directory)
        .listSync(recursive: true)
        .where((entity) => entity is File && entity.path.endsWith('.dart'))
        .map((entity) => entity.path)
        .toList();

    final totalFiles = dartFiles.length;
    var formattedFiles = 0;

    // Process files in chunks for parallel execution
    for (var i = 0; i < dartFiles.length; i += _concurrentOperations) {
      final chunk = dartFiles.sublist(
        i,
        i + _concurrentOperations > dartFiles.length
            ? dartFiles.length
            : i + _concurrentOperations,
      );

      // Format files in the current chunk concurrently
      await Future.wait(
        chunk.map((file) async {
          await _formatFile(file);
          formattedFiles++;
          printProgress('\rFormatting files: $formattedFiles/$totalFiles');
        }),
      );
    }

    print('\n'); // New line after progress
    printSuccess('Formatting completed!\n');
  } catch (e) {
    printError('Error formatting directory $directory: $e');
  }
}
