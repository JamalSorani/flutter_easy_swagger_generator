## 0.1.0

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
