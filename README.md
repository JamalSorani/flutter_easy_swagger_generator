<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.
-->

# Flutter Easy Swagger Generator

A Flutter package that automatically generates **Clean Architecture or MVVM code** from Swagger/OpenAPI specifications.

This version adds a **standalone CLI**, improved model generation, multipart/form-data support, full HTTP method support, and enhanced developer experience.

## Features

* Generates a **complete Clean Architecture structure** (`domain`, `infrastructure`, `presentation`) or 
* Supports **OpenAPI 3.0 features**
* Generates models, repositories, and network layers
* Handles **nested objects**, arrays, and complex data types
* Supports **multipart/form-data requests**
* Handles **all HTTP methods** (`GET`, `POST`, `PUT`, `DELETE`)
* Automatically serializes **header, query, and body parameters**
* Generates **BLoC, Provider, or Riverpod** for state management
* Includes **dependency injection setup** with `get_it`
* Creates **result builders** for consistent state and error management
* Supports **local files** and **remote URLs**
* Automatically formats generated code according to Dart guidelines

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_easy_swagger_generator: ^1.0.3

## Usage

### CLI Usage

```bash
# Generate from a local file
dart run flutter_easy_swagger_generator path/to/swagger.json

# Generate from a remote URL
dart run flutter_easy_swagger_generator https://api.example.com/swagger.json
```


### Dart API Usage

```dart
import 'package:flutter_easy_swagger_generator/flutter_easy_swagger_generator.dart';

void main() async {
  // Generate code from a local Swagger file
  await swaggerGenerator('path/to/swagger.json');

  // Or generate from a remote Swagger URL
  await swaggerGenerator('https://api.example.com/swagger.json');
}
```

#### Parameters

* `swaggerPath` (**String**): Path or URL to the Swagger JSON file.
* `category` (**String?**, optional): Generate code only for a specific API path category.
* `prefixesToRemove` (**List<String>?**, optional): Remove specified prefixes from generated class/file names.

## Clean Architecture Structure

```
lib/
  ├── app/
  │   ├── domain/
  │   │   ├── entities/
  │   │   └── repositories/
  │   ├── infrastructure/
  │   │   ├── models/
  │   │   ├── remote/
  │   │   └── repositories_implementation/
  │   ├── network/
  │   │   └── routes/
  │   ├── presentation/
  │   │   ├── bloc/
  │   │   ├── event/
  │   │   ├── state/
  │   │   ├── provider/
  │   │   └── riverpod/
  │   └── injection/
```

## MVVM Structure
```
lib/
└── feature_name/
├── models/
│ ├── response_model.dart
│ ├── request/
│ │ ├── request_param.dart
│ │ └── ...
│
├── data/
│ ├── remote/
│ │ └── api_service.dart
│ ├── repositories/
│ │ ├── repository.dart
│ │ └── repository_impl.dart
│
├── viewmodels/
│ └── feature_view_model.dart
│
├── views/
│ ├── feature_view.dart
│ └── ...
```

## Layer Features

### Entity Generation

* Converts OpenAPI schemas into Dart classes
* Handles nested objects and arrays
* Supports null safety

### Repository Generation

* Creates repository interfaces and implementations
* Supports CRUD operations and custom methods

### Network Layer

* Generates API clients
* Handles authentication
* Supports all HTTP methods
* Correctly maps request and response types

### Presentation Layer

* Generates code according to the selected state management type (BLoC, Provider, or Riverpod)
* Creates events, states, or notifier classes for UI
* Follows Flutter best practices
* Integrates state management with dependency injection


### Dependency Injection

* Sets up service locators
* Configures module dependencies

### Result Handling

* Generates result builders
* Provides consistent success/failure/loading handling

### Code Formatting

* Auto-formats all generated files
* Maintains consistent Dart style

## Contributing

Contributions are welcome! Please submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.
