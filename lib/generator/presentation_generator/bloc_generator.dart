import 'dart:io';

import 'package:flutter_easy_swagger_generator/classes/components.dart';
import 'package:flutter_easy_swagger_generator/classes/http_method_info.dart';
import 'package:flutter_easy_swagger_generator/helpers/converters.dart';
import '../../helpers/printer.dart';
import '../../helpers/utils.dart';

class BlocGenerator {
  final Map<String, Map<String, HttpMethodInfo>> paths;
  final Components components;
  final List<String> moduleList;
  final String mainPath;

  BlocGenerator({
    required this.paths,
    required this.components,
    required this.moduleList,
    required this.mainPath,
  });

  void generateBloc() {
    try {
      Map<String, List<MapEntry<String, Map<String, HttpMethodInfo>>>>
          groupedPaths = {};

      for (var path in paths.keys) {
        String category = getCategory(path);
        if (!groupedPaths.containsKey(category)) {
          groupedPaths[category] = [];
        }
        groupedPaths[category]!.add(MapEntry(path, paths[path]!));
      }

      for (var category in groupedPaths.keys) {
        _generateBlocForCategory(category, groupedPaths[category]!);
      }
    } catch (e) {
      printError('Error while generating Bloc: $e');
    }
  }

  void _generateBlocForCategory(
    String category,
    List<MapEntry<String, Map<String, HttpMethodInfo>>> categoryPaths,
  ) {
    String filePath =
        '$mainPath/$category/presentation/state/${category}_bloc.dart';

    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final buffer = StringBuffer();

    buffer.writeln("""
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/result_builder/result.dart';
import '../../application/${category}_facade.dart';""");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);

      buffer.writeln(
          "import '../../infrastructure/models/${actionName}_model.dart';");
    }

    // Add entity imports
    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = convertToSnakeCase(routeName);
      buffer
          .writeln("import '../../domain/entities/${actionName}_param.dart';");
    }

    buffer.writeln(
      """
part '${category}_event.dart';
part '${category}_state.dart';
""",
    );
    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);
    buffer.writeln(
      """
class ${capitalizedCategory}Bloc extends Bloc<${capitalizedCategory}Event, ${capitalizedCategory}State> {
  final ${capitalizedCategory}Facade _facade;
  ${capitalizedCategory}Bloc({required ${capitalizedCategory}Facade facade})
      : _facade = facade,
        super(${capitalizedCategory}State()) {""",
    );

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;

      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);
        buffer.writeln(
          """
    on<${actionName}Event>(_$methodName);""",
        );
      }
    }
    buffer.writeln("  }");

    for (var path in categoryPaths) {
      String routeName = getRouteName(path.key);
      String actionName = routeName;

      for (var method in path.value.entries) {
        HttpMethodInfo info = method.value;

        if (info.responses.response200 == null) continue;

        String methodName =
            actionName[0].toLowerCase() + actionName.substring(1);
        buffer.writeln(
          """

  _$methodName(${actionName}Event event, Emitter emit) async{
    emit(state.copyWith(${methodName}State: const Result.loading()));
    final response = await _facade.$methodName(
        ${methodName}Param: event.${methodName}Param);
    response.fold(
      (l) => emit(state.copyWith(${methodName}State: Result.error(error: l))),
      (r) => emit(state.copyWith(${methodName}State: Result.loaded(data: r))),
    );
  }""",
        );
      }
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }
}
