import 'dart:io';

import '../../helpers/imports.dart';

/// A generator responsible for creating remote data source classes.
///
/// The generated remote classes:
/// - Use [Dio] for making HTTP requests.
/// - Map requests and responses to entities and models.
/// - Handle API errors consistently using `throwDioException`.
class RemoteGenerator {
  final Map<String, List<RouteInfo>> groupedRoutes;

  final String mainPath;

  /// Creates a [RemoteGenerator] instance with the required inputs.
  RemoteGenerator({
    required this.groupedRoutes,
    required this.mainPath,
  });

  /// Generates the remote data source for a specific [category].
  ///
  /// - Creates a class `<Category>Api` that wraps HTTP requests.
  /// - Defines methods for each endpoint in the category.
  /// - Converts request entities to JSON and parses responses into models.
  void generateRemoteForCategory(
    String category,
  ) {
    List<RouteInfo> categoryPaths = groupedRoutes[category]!;

    String filePath =
        '$mainPath/$category/infrastructure/datasource/remote/${category}_remote.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    // Imports
    buffer.writeln("import 'package:dio/dio.dart';");
    buffer.writeln("import '../../../../url.dart';");
    buffer.writeln(
        "import '../../../../../common/network/exception/error_handler.dart';");

    // Add model imports
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();

      buffer.writeln("import '../../models/${actionName}_model.dart';");
    }

    // Add entity imports
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName.toSnakeCase();
      buffer.writeln(
          "import '../../../domain/entities/${actionName}_param.dart';");
    }

    buffer.writeln();

    // Remote API class definition
    buffer.writeln(
        "class ${(category[0].toUpperCase() + category.substring(1))}Api {");
    buffer.writeln("  final Dio _dio;");

    buffer.writeln(
        "  const ${(category[0].toUpperCase() + category.substring(1))}Api(Dio dio) : _dio = dio;");

    // Generate methods for each API endpoint
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.fullRoute);
      String actionName = routeName;

      String methodName = actionName[0].toLowerCase() + actionName.substring(1);
      HttpMethodType requestType = path.httpMethod;

      buffer.writeln("""
  /// Sends a [$requestType] request to the [$actionName] endpoint.
  ///
  /// - Request body is created from [${methodName}Param].
  /// - On success: returns [${actionName}Model].
  /// - On error: throws an exception handled by [throwDioException].
  Future<${actionName}Model> $methodName({
    required ${actionName}Param ${methodName}Param,
  }) {
    return throwDioException(() async {
      final response = await _dio.${requestType.name}(
        AppUrl.${actionName.toCamelCase()},
        data: ${methodName}Param.toJson(),
      );
      return ${actionName}Model.fromJson(response.data);
    });
  }
""");
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
