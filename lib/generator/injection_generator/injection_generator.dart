import 'dart:io';

import '../../helpers/converters.dart';
import '../../helpers/printer.dart';

class InjectionGenerator {
  final List<String> moduleList;
  final String mainPath;
  InjectionGenerator({
    required this.mainPath,
    required this.moduleList,
  });

  void generateInjection() {
    try {
      for (var module in moduleList) {
        _generateInjectionForEachCategory(module);
      }
      _generateMainInjection();
    } catch (e) {
      printError('Error while generating routes: $e');
    }
  }

  _generateInjectionForEachCategory(String category) {
    String filePath =
        '${mainPath.contains("example") ? "example/" : ""}lib/common/injection/src/${convertToSnakeCase(category)}_injection.dart';
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final StringBuffer buffer = StringBuffer();

    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);
    buffer.writeln(
      """
import 'package:dio/dio.dart';
import '../../../app/$category/application/${category}_facade.dart';
import '../../../app/$category/domain/repository/${category}_repository.dart';
import '../../../app/$category/infrastructure/datasource/remote/${category}_api.dart';
import '../../../app/$category/infrastructure/repo_imp/${category}_repo_imp.dart';
import '../../../app/$category/presentation/state/${category}_bloc.dart';
import '../injection.dart';

Future<void> ${category}Injection() async {
  getIt.registerSingleton<${capitalizedCategory}Api>(
    ${capitalizedCategory}Api(
      getIt<Dio>(),
    ),
  );

  getIt.registerSingleton<${capitalizedCategory}Repository>(
    ${capitalizedCategory}RepoImp(
      api: getIt<${capitalizedCategory}Api>(),
    ),
  );

  getIt.registerSingleton<${capitalizedCategory}Facade>(
    ${capitalizedCategory}Facade(
      repository: getIt<${capitalizedCategory}Repository>(),
    ),
  );

  getIt.registerSingleton<${capitalizedCategory}Bloc>(
    ${capitalizedCategory}Bloc(
      facade: getIt<${capitalizedCategory}Facade>(),
    ),
  );
}""",
    );
    file.writeAsStringSync(buffer.toString());
  }

  _generateMainInjection() {
    String filePath =
        '${mainPath.contains("example") ? "example/" : ""}lib/common/injection/injection.dart';
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final StringBuffer buffer = StringBuffer();
    buffer.writeln("import 'package:get_it/get_it.dart';");

    for (var module in moduleList) {
      buffer.writeln(
          "import 'src/${convertToSnakeCase(module)}_injection.dart';");
    }

    buffer.writeln();

    buffer.writeln("""
final GetIt getIt = GetIt.instance;

Future<void> initInjection() async {
${moduleList.map((module) => "  await ${module}Injection();").join("\n")}
}
""");
    file.writeAsStringSync(buffer.toString());
  }
}
