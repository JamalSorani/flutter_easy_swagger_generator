import 'dart:io';

class FileWriter {
  static void writeToFile(
      String className, String classContent, String outputDir) {
    final outputFile = File('$outputDir/$className.dart');
    outputFile.writeAsStringSync(classContent);
  }
}
