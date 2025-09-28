import 'dart:io';

import '../../helpers/imports.dart';

/// A generator responsible for creating dependency injection setup files.
///
/// This generator creates:
/// - Individual injection files for each feature/module.
/// - A main `injection.dart` file that initializes all module injections.
///
/// The generated code uses the [GetIt] service locator for managing
/// dependencies such as API clients, repositories, facades, and blocs.
class InjectionGenerator {
  /// The list of modules for which injection code will be generated.
  final List<String> moduleList;

  /// The base path where generated files will be stored.
  final String mainPath;

  /// Creates a new [InjectionGenerator].
  InjectionGenerator({
    required this.mainPath,
    required this.moduleList,
  });

  /// Generates dependency injection setup files.
  ///
  /// Steps:
  /// 1. Creates an injection file for each module in [moduleList].
  /// 2. Creates a main `injection.dart` file to initialize all modules.
  void generateInjection() {
    try {
      for (var module in moduleList) {
        _generateInjectionForEachCategory(module);
      }
      _generateMainInjection();
    } catch (e,s) {
      printError('Error while generating injection: $e');
      printError(s.toString());
    }
  }

  /// Generates an injection file for a specific [category].
  ///
  /// Example:
  /// - For `user`, generates `user_injection.dart`.
  /// - Registers API, Repository, Facade, and Bloc into [GetIt].
  _generateInjectionForEachCategory(String category) {
    if(category.isEmpty){
      category=ConstantsHelper.generalCategory;
    }
    String filePath =
        '${mainPath.contains("example") ? "example/" : ""}lib/common/injection/src/${category.toSnakeCase()}_injection.dart';
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final StringBuffer buffer = StringBuffer();

    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);

    // Generate DI setup code for this category
    buffer.writeln(
      """
import 'package:dio/dio.dart';
import '../../../app/$category/application/${category}_facade.dart';
import '../../../app/$category/domain/repository/${category}_repository.dart';
import '../../../app/$category/infrastructure/datasource/remote/${category}_remote.dart';
import '../../../app/$category/infrastructure/repo_imp/${category}_repo_imp.dart';
import '../../../app/$category/presentation/state/${category}_bloc.dart';
import '../injection.dart';

/// Registers all dependencies for the [$category] module.
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

  /// Generates the main `injection.dart` file.
  ///
  /// - Imports all module-specific injection files.
  /// - Exposes a global [GetIt] instance named [getIt].
  /// - Provides [initInjection] function to initialize all modules.
  _generateMainInjection() {
    String filePath =
        '${mainPath.contains("example") ? "example/" : ""}lib/common/injection/injection.dart';
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final StringBuffer buffer = StringBuffer();

    // Import GetIt and module injections
    buffer.writeln("import 'package:get_it/get_it.dart';");

    for (var module in moduleList) {
      buffer.writeln("import 'src/${module.toSnakeCase()}_injection.dart';");
    }

    buffer.writeln();

    // Generate main GetIt initialization code
    buffer.writeln("""
final GetIt getIt = GetIt.instance;

/// Initializes dependency injection for all modules.
Future<void> initInjection() async {
${moduleList.map((module) => "  await ${module}Injection();").join(LINE)}
}
""");
    file.writeAsStringSync(buffer.toString());
  }
}
