import 'dart:io';
import 'package:flutter_easy_swagger_generator/helpers/printer.dart';
import 'package:flutter_easy_swagger_generator/flutter_easy_swagger_generator.dart';

/// Example demonstrating how to use the Flutter Easy Swagger Generator package.
///
/// This example shows how to:
/// 1. Generate code from a local Swagger file
/// 2. Generate code from a remote Swagger URL
/// 3. Handle command-line arguments
///
/// To run this example:
/// ```bash
/// # Run with default examples
/// dart run example/lib/main.dart
///
/// # Generate from a local file
/// dart run example/lib/main.dart path/to/swagger.json
///
/// # Generate from a remote URL
/// dart run example/lib/main.dart https://api.example.com/swagger.json
/// ```
void main(List<String> arguments) async {
  printInfo('Flutter Easy Swagger Generator Example');
  printInfo('=====================================');

  // Check if a source was provided as an argument
  if (arguments.isEmpty) {
    printInfo('\nNo source provided. Using default examples:');
    printInfo('-------------------------------------------');

    // Example 1: Generate code from a local swagger file
    printInfo('\nExample 1: Generate from local swagger file');
    printInfo('-------------------------------------------');

    const localSwaggerPath = 'example/swagger.json';
    if (File(localSwaggerPath).existsSync()) {
      printInfo('Generating code from local swagger file...');
      await swaggerGenerator(localSwaggerPath);
    } else {
      printWarning('Local swagger file not found. Skipping example 1.');
    }

    // Example 2: Generate code from a remote swagger file
    printInfo('\nExample 2: Generate from remote swagger file');
    printInfo('--------------------------------------------');

    const remoteSwaggerUrl = 'https://petstore.swagger.io/v2/swagger.json';
    printInfo('Generating code from remote swagger URL...');
    await swaggerGenerator(remoteSwaggerUrl);

    // Example 3: Generate code for a single category from a local swagger file
    printInfo(
        '\nExample 3: Generate code for a single category (e.g., "user")');
    printInfo('----------------------------------------------------------');

    if (File(localSwaggerPath).existsSync()) {
      printInfo(
          'Generating code for the "user" category from local swagger file...');
      await swaggerSingleCategoryGenerator(localSwaggerPath, 'user');
    } else {
      printWarning('Local swagger file not found. Skipping example 3.');
    }
  } else {
    // Use the provided source
    final source = arguments[0];
    final isUrl = source.startsWith('http://') || source.startsWith('https://');

    printInfo(
        '\nGenerating code from ${isUrl ? 'remote URL' : 'local file'}: $source');
    printInfo('-------------------------------------------');

    await swaggerGenerator(source);
  }

  printSuccess('\nExample completed!');
}
