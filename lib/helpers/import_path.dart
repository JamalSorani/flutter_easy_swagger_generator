import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class ImportPath {
  final bool isMVVM;
  final String actionName;

  ImportPath({
    required this.isMVVM,
    required this.actionName,
  });

  String get entityFilePath {
    String actionName2 = actionName.toSnakeCase();
    if (isMVVM) {
      return "models/request/${actionName2}_param.dart";
    }
    return "domain/entities/${actionName2}_param.dart";
  }

  String get modelFilePath {
    String actionName2 = actionName.toSnakeCase();
    if (isMVVM) {
      return "models/${actionName2}_model.dart";
    }
    return "infrastructure/models/${actionName2}_model.dart";
  }
}
