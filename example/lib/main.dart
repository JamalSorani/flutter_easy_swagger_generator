import 'dart:io';
import 'package:flutter_easy_swagger_generator/helpers/printer.dart';
import 'package:flutter_easy_swagger_generator/helpers/formatter.dart';

void main(List<String> arguments) async {
  printInfo('Flutter Easy Swagger Generator Example');
  printInfo('=====================================');

  // Example 1: Generate code from a local swagger file
  printInfo('\nExample 1: Generate from local swagger file');
  printInfo('-------------------------------------------');

  const localSwaggerPath = 'example/swagger.json';
  if (File(localSwaggerPath).existsSync()) {
    printInfo('Generating code from local swagger file...');
    await generateFromSwagger(localSwaggerPath);
  } else {
    printWarning('Local swagger file not found. Skipping example 1.');
  }

  // Example 2: Generate code from a remote swagger file
  printInfo('\nExample 2: Generate from remote swagger file');
  printInfo('--------------------------------------------');

  const remoteSwaggerUrl = 'https://petstore.swagger.io/v2/swagger.json';
  printInfo('Downloading swagger file from $remoteSwaggerUrl...');

  try {
    final tempFile = await _downloadSwaggerFile(remoteSwaggerUrl);
    printInfo('Generating code from remote swagger file...');
    await generateFromSwagger(tempFile.path);
    tempFile.deleteSync();
  } catch (e) {
    printError('Failed to download or process remote swagger file: $e');
  }

  printSuccess('\nExample completed!');
}

/// Downloads a swagger file from a URL and returns a temporary file
Future<File> _downloadSwaggerFile(String url) async {
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(url));
  final response = await request.close();

  if (response.statusCode != 200) {
    throw Exception('Failed to download swagger file: ${response.statusCode}');
  }

  final tempFile = File('${Directory.systemTemp.path}/remote_swagger.json');
  final sink = tempFile.openWrite();
  await response.pipe(sink);
  await sink.close();
  client.close();

  return tempFile;
}

/// Generates code from a swagger file
Future<void> generateFromSwagger(String swaggerPath) async {
  try {
    // Check if swagger file exists
    if (!File(swaggerPath).existsSync()) {
      printError('Error: Swagger file not found at $swaggerPath');
      return;
    }

    // Generate code
    printInfo('Generating code from swagger file: $swaggerPath');
    main([swaggerPath]);
    printSuccess('Code generation completed!');

    // Format generated files
    if (promptUser('Do you want to format the generated files?') == 'y') {
      printInfo('Formatting generated files...');
      await formatDirectory('lib/app');
    }
  } catch (e) {
    printError('Error generating code: $e');
  }
}
