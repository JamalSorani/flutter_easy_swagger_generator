// import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

// /// A generator responsible for creating model classes from Swagger definitions.
// ///
// /// The generated model classes:
// /// - Represent the response structures of API endpoints.
// /// - Are based on the `200` success response.
// /// - Use the provided Swagger [components] for schema references.
// class ModelsGenerator {
//   /// The list of modules to include in generation.
//   final List<String> moduleList;

//   /// The map of API paths and their associated HTTP methods.
//   final List<Paths> paths;

//   /// The components defined in the Swagger file.
//   final Components components;

//   /// The main base path where files will be generated.
//   final String mainPath;

//   /// Creates a [ModelsGenerator] instance.
//   ModelsGenerator({
//     required this.moduleList,
//     required this.paths,
//     required this.components,
//     required this.mainPath,
//   });

//   /// Generates model classes for all API endpoints.
//   ///
//   /// Steps:
//   /// 1. Iterates over each [path] and [method].
//   /// 2. Skips endpoints without a `200` response.
//   /// 3. For each valid response, generates a Dart model class
//   ///    using [ModelClassGenerator].
//   generateModels() {
//     for (var path in paths) {
//       // Skip if no 200 OK response defined
//       if (path.httpMethodInfo.responses.response200 == null) continue;

//       // Generate models for response content types
//       if (path.httpMethodInfo.responses.response200!.content != null) {
//         path.httpMethodInfo.responses.response200!.content!
//             .forEach((contentType, content) {
//           if (content.schema == null) return;

//           // Generate model class from schema
//           ModelClassGenerator(
//             moduleList: moduleList,
//             components: components,
//             mainPath: mainPath,
//           ).generateClass(path);
//         });
//       }
//     }
//   }
// }
