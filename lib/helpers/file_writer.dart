import 'dart:io';

/// A helper class for writing Dart class content into files.
///
/// Provides a simple utility for generating and saving `.dart` files
/// during code generation workflows.
class FileWriter {
  /// Writes [classContent] to a file inside [outputDir].
  ///
  /// - The file will be named `[className].dart`.
  /// - If the file already exists, its contents will be overwritten.
  ///
  /// Example:
  /// ```dart
  /// FileWriter.writeToFile(
  ///   "user_model",
  ///   "class UserModel { ... }",
  ///   "lib/models",
  /// );
  /// // Creates or overwrites lib/models/user_model.dart
  /// ```
  static void writeToFile(
      String className, String classContent, String outputDir) {
    final outputFile = File('$outputDir/$className.dart');
    outputFile.writeAsStringSync(classContent);
  }
}
