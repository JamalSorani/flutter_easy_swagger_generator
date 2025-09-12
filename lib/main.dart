/// Flutter Easy Swagger Generator
///
/// A Flutter package that generates clean architecture code from Swagger/OpenAPI specifications.
/// This package helps you quickly set up a Flutter project with a clean architecture structure
/// by automatically generating the necessary code from your API specification.
///
/// ## Features
///
/// * Generates clean architecture code structure
/// * Supports both local Swagger files and remote URLs
/// * Creates entities, models, repositories, and network layers
/// * Generates application layer with use cases
/// * Supports concurrent code generation
///
/// ## Usage
///
/// ```dart
/// import 'package:flutter_easy_swagger_generator/main.dart';
///
/// void main(List<String> arguments) async {
///   // Generate from local file
///   await swaggerGenerator('path/to/swagger.json');
///
///   // Or generate from remote URL
///   await swaggerGenerator('https://api.example.com/swagger.json');
/// }
/// ```
///
/// For more information, see the [README](https://pub.dev/packages/flutter_easy_swagger_generator).
library flutter_easy_swagger_generator;

import 'package:flutter_easy_swagger_generator/helpers/printer.dart';

import 'flutter_easy_swagger_generator.dart';

/// Entry point for the application.
///
/// Takes a list of command line arguments where the first argument
/// should be the path to the Swagger file or a URL to the Swagger specification.
///
/// Example:
/// ```dart
/// dart run main.dart path/to/swagger.json
/// ```
///
/// Or with a remote URL:
/// ```dart
/// dart run main.dart https://api.example.com/swagger.json
/// ```
void main(List<String> arguments) async {
  if (arguments.isEmpty) {
    printWarning('Usage: dart run main.dart [path_to_swagger.json]');
    return;
  }
  await swaggerGenerator(
    arguments[0],
  );
  // await swaggerGenerator(arguments[0], prefixesToRemove: ['Mobile']);

  //  await swaggerSingleCategoryGenerator(
  //   arguments[0],
  //   'Supplier',
  //   prefixesToRemove: ['Dashboard'],
  // );
}
// dart run lib/main.dart lib/swagger.json
