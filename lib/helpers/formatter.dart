import 'dart:io';
import 'dart:async';
import 'package:flutter_easy_swagger_generator/helpers/printer.dart';

/// Number of concurrent formatting operations - increased for better performance
const int _concurrentOperations = 5;

/// Batch size for progress updates to reduce console output overhead
const int _progressBatchSize = 5;

/// Formats a single file and returns success status
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

/// Formats all Dart files in the given directory using optimized parallel processing
Future<void> formatDirectory(String directory) async {
  final stopwatch = Stopwatch()..start();

  try {
    // Get all .dart files in parallel using compute
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

    // Create batches of files for concurrent processing
    final batches = <List<String>>[];
    for (var i = 0; i < dartFiles.length; i += _concurrentOperations) {
      batches.add(dartFiles.sublist(
        i,
        i + _concurrentOperations > dartFiles.length
            ? dartFiles.length
            : i + _concurrentOperations,
      ));
    }

    // Process batches
    for (final batch in batches) {
      final results = await Future.wait(
        batch.map((file) => _formatFile(file)),
        eagerError: false,
      );

      // Update counters
      final successCount = results.where((success) => success).length;
      formattedFiles += successCount;
      failedFiles += results.length - successCount;

      // Update progress every _progressBatchSize batches
      if (formattedFiles % _progressBatchSize == 0 ||
          formattedFiles == totalFiles) {
        printProgress(
            '\rFormatting: $formattedFiles/$totalFiles files (${(formattedFiles / totalFiles * 100).toStringAsFixed(1)}%)');
      }
    }

    // Final status
    final duration = stopwatch.elapsed;
    print('\n'); // New line after progress
    printSuccess('''
Formatting completed in ${duration.inSeconds}.${duration.inMilliseconds % 1000}s
✓ Successfully formatted: $formattedFiles files
${failedFiles > 0 ? '✗ Failed to format: $failedFiles files' : ''}
''');
  } catch (e) {
    printError('Error formatting directory $directory: $e');
  }
}
