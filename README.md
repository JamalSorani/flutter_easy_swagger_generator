<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# Flutter Easy Swagger Generator

A Flutter package that automatically generates clean architecture code from Swagger/OpenAPI specifications.

## Features

- Generates complete clean architecture structure
- Supports all OpenAPI 3.0 features
- Generates models, repositories, and network layers
- Handles complex data types and references
- Supports multipart/form-data
- Includes code formatting
- Provides detailed progress feedback
- Supports both local files and remote URLs

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_easy_swagger_generator: ^1.0.0
```

## Usage

### Basic Usage

```dart
import 'package:flutter_easy_swagger_generator/main.dart';

void main(List<String> arguments) async {
  // Generate code from a local swagger file
  await swaggerGenerator('path/to/swagger.json');
  
  // Or generate from a remote URL
  await swaggerGenerator('https://api.example.com/swagger.json');
}
```

### Command Line

```bash
# Generate from local file
dart run main.dart path/to/swagger.json

# Generate from remote URL
dart run main.dart https://api.example.com/swagger.json
```

### Example

See the `example` directory for a complete working example:

```dart
import 'package:flutter_easy_swagger_generator/generator/swagger_generator.dart';

void main() async {
  // Example 1: Generate from local swagger file
  await swaggerGenerator('example/swagger.json');

  // Example 2: Generate from remote swagger URL
  await swaggerGenerator('https://petstore.swagger.io/v2/swagger.json');
}
```

## Generated Structure

The generator creates the following structure:

```
lib/
  ├── app/
  │   ├── domain/
  │   │   ├── entities/
  │   │   └── repositories/
  │   ├── infrastructure/
  │   │   ├── models/
  │   │   ├── remote/
  │   │   └── repositories/
  │   └── network/
  │       └── routes/
```

## Features

### Entity Generation
- Automatically generates Dart classes from OpenAPI schemas
- Handles nested objects and arrays
- Supports all primitive types
- Generates proper null safety

### Repository Generation
- Creates repository interfaces
- Generates repository implementations
- Handles CRUD operations
- Supports custom methods

### Network Layer
- Generates API clients
- Handles authentication
- Supports all HTTP methods
- Manages request/response types

### Code Formatting
- Automatically formats generated code
- Follows Dart style guidelines
- Maintains consistent formatting

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
