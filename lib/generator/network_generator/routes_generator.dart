import 'dart:io';

import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

/// A generator that creates a Dart class (`AppUrl`) containing
/// all API routes extracted from Swagger and grouped by category.
///
/// Each category is separated with a banner comment generated
/// by [makeBanner], and each route is declared as a `static const String`.
///
/// Example output:
/// ```dart
/// class AppUrl {
///   //! ORDER ================================================================
///   static const String orderGetById = 'order/getById';
///
///   //! CART =================================================================
///   static const String cartAddItem = 'cart/addItem';
/// }
/// ```
class RoutesGenerator {
  /// A map of grouped routes, where the key is the category
  /// (e.g. `order`, `cart`) and the value is a list of [RouteInfo]
  /// representing individual API routes.
  final Map<String, List<RouteInfo>> groupedRoutes;

  /// The main output directory path where the generated `url.dart`
  /// file will be stored.
  final String mainPath;

  RoutesGenerator({required this.groupedRoutes, required this.mainPath});

  /// Generates the `AppUrl` class and writes it to `url.dart` inside [mainPath].
  ///
  /// - Iterates through [groupedRoutes] and converts them into
  ///   `static const` route fields.
  /// - Uses [makeBanner] to insert category headers.
  /// - Removes `/api/` prefix from each route before writing.
  /// - Stores the grouped routes in [Store.groupedRoutes] for reuse.
  void generateRoutes() {
    try {
      final List<String> formattedGroups = [];

      // Build formatted route strings grouped by category
      groupedRoutes.forEach((category, routes) {
        formattedGroups.add("  ${makeBanner(category)}");
        formattedGroups.addAll(
          routes.map(
            (e) =>
                "  static const String ${getRouteName(e.fullRoute).toCamelCase()} = '${e.fullRoute.replaceAll('/api/', '')}';",
          ),
        );
        formattedGroups.add('');
      });

      // Final Dart class content
      final generatedClass = '''
class AppUrl {
${formattedGroups.join(line)}
}
''';

      // Ensure output folder exists
      createFolder(mainPath);

      // Write to file
      final outputFile = File("$mainPath/url.dart");
      outputFile.writeAsStringSync(generatedClass);
    } catch (e, s) {
      printError('Error while generating routes: $e');
      printError(s.toString());
    }
  }
}
