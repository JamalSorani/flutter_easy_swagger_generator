## 1.0.2
* **State Management Selection Enhanced**
Users can now choose the state management type during code generation:

* **BLoC**
* **Provider**
* **Riverpod**

* **swaggerGenerator and InjectionGenerator updated to handle multiple state management types.**

* **Dependency injection files now conditionally import and register the selected state management modules for each feature.**

* **Generated code is fully compatible with any combination of state management patterns.**

* **Default selection remains BLoC if no input is provided.**

* **Injection Generator Update**

* **Automatically generates DI setup for all selected state management types.**

* **Avoids redundant imports and registrations when only one type is selected.**

* **Simplifies module injection for multi-pattern projects.**

* **CLI Updates**

* **Added option to select state management type via CLI prompt.**

* **Shows clear instructions for selecting single or all state management types.**

* **Ensures consistent code generation for multi-pattern projects.**

## 1.0.1
* Update lints

## 1.0.0
### Major Changes
* **CLI Generator Added**
  * Added a standalone CLI entry point (`bin/flutter_easy_swagger_generator.dart`) to run the generator directly:
    ```bash
    dart run flutter_easy_swagger_generator <path_to_swagger.json> [--watch]
    ```
  * Fully independent of `build_runner`, but works similarly with live regeneration.

* **Improved Response Model Generation**
  * Models for API responses are now generated with correct and strongly typed `fromJson` and `toJson` methods for requests.
  * Automatically resolves `$ref` objects and nested types into separate model classes.
  * Added null safety and list handling (`List<T>` parsing).

* **Enhanced Request Handling**
  * Now supports **all HTTP methods**:
    - `GET`, `POST`, `PUT`, `DELETE`, and others.
  * Automatically detects and generates correct API call methods.

* **Multipart Form Request Support**
  * Automatically detects endpoints requiring multipart/form-data.
  * Generates correct Dio multipart request handling with `FormData` and `MultipartFile`.

* **Comprehensive Parameter Support**
  * Handles all request parameter types:
    - **Header parameters**
    - **Query parameters**
    - **Body parameters**
  * Automatically maps them to generated entity classes and serializes them in `toJson()`.

* **Documentation Improvements**
  * Added clear inline documentation for:
    - CLI usage
    - Swagger generator functions
    - Generated code examples
  * Updated README with new usage instructions and examples for CLI mode.

---

## 0.0.3
* Fixed LICENSE file error

## 0.0.2
* Added new parameters to `swaggerGenerator`:
  * `category` for filtering generated code by API path category
  * `prefixesToRemove` for removing specific prefixes from generated class and file names
* Added `swaggerSingleCategoryGenerator` function to generate code for a single API category
* Documented `swaggerSingleCategoryGenerator` in code and README
* Added usage example for `swaggerSingleCategoryGenerator` in README and example
* Updated documentation and usage examples in README.md
* Improved code generation flexibility and customization

## 0.0.1
* Initial release of flutter_easy_swagger_generator
* Features:
  * Automatic generation of Dart models from Swagger/OpenAPI specifications
  * Support for nested references and complex data structures
  * Built-in support for BLoC pattern integration
  * Dependency injection support with get_it
  * Cross-platform compatibility (iOS, Android, Web)
  * Comprehensive documentation and examples
  * Support for various data types and formats
  * Automatic null safety support
  * Customizable model generation with annotations
  * Support for enums and complex nested objects
  * Web platform support with universal_html package
  * Comprehensive error handling and validation
  * Support for various HTTP methods and API endpoints
  * Automatic generation of API client code
  * Support for authentication and headers
  * Built-in support for common HTTP clients (dio, http)
  * Type-safe API calls with generated models
  * Support for file uploads and downloads
  * Comprehensive logging and debugging support
