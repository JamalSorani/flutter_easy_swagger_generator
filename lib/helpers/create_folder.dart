import 'dart:io';

/// Creates a folder at the given [path] if it does not already exist.
///
/// - If the folder already exists, nothing happens.
/// - If the folder (or any of its parent directories) does not exist,
///   they will be created recursively.
///
/// Example:
/// ```dart
/// createFolder("lib/features/order/domain/entities");
/// // Ensures the directory structure exists.
/// ```
void createFolder(String path) {
  final folder = Directory(path);
  if (!folder.existsSync()) {
    folder.createSync(recursive: true);
  }
}
