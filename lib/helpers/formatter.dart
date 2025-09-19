import 'dart:async';
import 'dart:io';
import 'package:flutter_easy_swagger_generator/helpers/printer.dart';

/// The maximum number of concurrent formatting operations
/// that can run in parallel.
const int _concurrentOperations = 5;

/// Number of files to process before showing progress output.
const int _progressBatchSize = 5;

/// Formats a single Dart file using the `dart format` command.
///
/// Returns:
/// - `true` if formatting succeeded.
/// - `false` if formatting failed or an exception occurred.
///
/// The [filePath] must point to a valid `.dart` file.
Future<bool> _formatFile(String filePath) async {
  try {
    final process =
        await Process.run('dart', ['format', filePath], runInShell: true);
    return process.exitCode == 0;
  } catch (e) {
    printError('Error formatting $filePath: $e');
    return false;
  }
}

/// Recursively formats all Dart files in the given [directory].
///
/// - Uses the `dart format` command.
/// - Processes files in batches, with [_concurrentOperations] files
///   formatted in parallel.
/// - Displays progress after every [_progressBatchSize] files.
/// - Prints a summary with the total time taken, number of files formatted,
///   and any failures.
///
/// Example:
/// ```dart
/// await formatDirectory("lib");
/// ```
Future<void> formatDirectory(String directory) async {
  final stopwatch = Stopwatch()..start();

  try {
    // Collect all Dart files recursively inside the directory
    final dartFiles = await Directory(directory)
        .list(recursive: true)
        .where((entity) => entity is File && entity.path.endsWith('.dart'))
        .map((entity) => entity.path)
        .toList();

    if (dartFiles.isEmpty) {
      printWarning('No Dart files found in $directory');
      return;
    }

    final totalFiles = dartFiles.length;
    var formattedFiles = 0;
    var failedFiles = 0;

    // Split files into batches for parallel processing
    final batches = <List<String>>[];
    for (var i = 0; i < dartFiles.length; i += _concurrentOperations) {
      batches.add(dartFiles.sublist(
        i,
        i + _concurrentOperations > dartFiles.length
            ? dartFiles.length
            : i + _concurrentOperations,
      ));
    }

    // Process each batch concurrently
    for (final batch in batches) {
      final results = await Future.wait(
        batch.map((file) => _formatFile(file)),
        eagerError: false,
      );

      final successCount = results.where((success) => success).length;
      formattedFiles += successCount;
      failedFiles += results.length - successCount;

      // Show progress periodically
      if (formattedFiles % _progressBatchSize == 0 ||
          formattedFiles == totalFiles) {
        printProgress(
            '\rFormatting: $formattedFiles/$totalFiles files (${(formattedFiles / totalFiles * 100).toStringAsFixed(1)}%)');
      }
    }

    // Print summary
    final duration = stopwatch.elapsed;
    print('\n');
    printSuccess('''
Formatting completed in ${duration.inSeconds}.${duration.inMilliseconds % 1000}s
✓ Successfully formatted: $formattedFiles files
${failedFiles > 0 ? '✗ Failed to format: $failedFiles files' : ''}
''');
  } catch (e) {
    printError('Error formatting directory $directory: $e');
  }
}
