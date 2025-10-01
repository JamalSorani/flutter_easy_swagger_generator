import 'dart:io';

import 'package:flutter_easy_swagger_generator/flutter_easy_swagger_generator.dart';
import '../../helpers/imports.dart';

/// A generator responsible for creating dependency injection setup files.
///
/// This generator creates:
/// - Individual injection files for each feature/module.
/// - A main `injection.dart` file that initializes all module injections.
///
/// The generated code uses the [GetIt] service locator for managing
/// dependencies such as API clients, repositories, facades, and state management.
class InjectionGenerator {
  /// The list of modules for which injection code will be generated.
  final List<String> moduleList;

  /// The base path where generated files will be stored.
  final String mainPath;

  /// The state management type.
  final StateManagementType stateManagementType;

  final bool isMVVM;

  /// Creates a new [InjectionGenerator].
  InjectionGenerator({
    required this.mainPath,
    required this.moduleList,
    required this.stateManagementType,
    required this.isMVVM,
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
    } catch (e, s) {
      printError('Error while generating injection: $e');
      printError(s.toString());
    }
  }

  /// Generates an injection file for a specific [category].
  ///
  /// Example:
  /// - For `user`, generates `user_injection.dart`.
  /// - Registers API, Repository, Facade, and all selected state management into [GetIt].
  void _generateInjectionForEachCategory(String category) {
    if (category.isEmpty) {
      category = ConstantsHelper.generalCategory;
    }

    String filePath =
        '${mainPath.contains("example") ? "example/" : ""}lib/common/injection/src/${category.toSnakeCase()}_injection.dart';
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final StringBuffer buffer = StringBuffer();

    String capitalizedCategory =
        category[0].toUpperCase() + category.substring(1);

    // Generate DI setup code for this category
    buffer.writeln("""
import 'package:dio/dio.dart';
${isMVVM ? "import '../../../app/$category/data/repositories/${category}_repository.dart';" : "import '../../../app/$category/domain/repository/${category}_repository.dart';"}
${isMVVM ? "import '../../../app/$category/data/remote/${category}_remote.dart';" : "import '../../../app/$category/infrastructure/datasource/remote/${category}_remote.dart';"}
${isMVVM ? "import '../../../app/$category/data/repositories/${category}_repo_imp.dart';" : "import '../../../app/$category/infrastructure/repo_imp/${category}_repo_imp.dart';"}
import '../injection.dart';
""");

    // Conditionally import state management files
    if (stateManagementType == StateManagementType.bloc ||
        stateManagementType == StateManagementType.all) {
      buffer.writeln(
          "import '../../../../app/$category/presentation/state/bloc/${category}_bloc.dart';");
    }
    if (stateManagementType == StateManagementType.provider ||
        stateManagementType == StateManagementType.all) {
      if (isMVVM) {
        buffer.writeln(
            "import '../../../app/$category/viewmodels/${category}_view_model.dart';");
      } else {
        buffer.writeln(
            "import '../../../../app/$category/presentation/state/provider/${category}_provider.dart';");
      }
    }
    if (stateManagementType == StateManagementType.riverpod ||
        stateManagementType == StateManagementType.all) {
      buffer.writeln(
          "import '../../../../app/$category/presentation/state/riverpod/${category}_riverpod.dart';");
    }

    buffer.writeln("""
/// Registers all dependencies for the [$category] module.
Future<void> ${category}Injection() async {
  getIt.registerSingleton<${capitalizedCategory}Remote>(
    ${capitalizedCategory}Remote(
      getIt<Dio>(),
    ),
  );

  getIt.registerSingleton<${capitalizedCategory}Repository>(
    ${capitalizedCategory}RepoImp(
      remote: getIt<${capitalizedCategory}Remote>(),
    ),
  );

""");

    // Register selected state management
    if (stateManagementType == StateManagementType.bloc ||
        stateManagementType == StateManagementType.all) {
      buffer.writeln("""
  getIt.registerSingleton<${capitalizedCategory}Bloc>(
    ${capitalizedCategory}Bloc(
      repository: getIt<${capitalizedCategory}Repository>(),
    ),
  );
""");
    }

    if (stateManagementType == StateManagementType.provider ||
        stateManagementType == StateManagementType.all) {
      final providerClassName = isMVVM
          ? "${capitalizedCategory}ViewModel"
          : "${capitalizedCategory}Provider";
      buffer.writeln("""
  getIt.registerSingleton<$providerClassName>(
    $providerClassName(
      repository: getIt<${capitalizedCategory}Repository>(),
    ),
  );
""");
    }

    if (stateManagementType == StateManagementType.riverpod ||
        stateManagementType == StateManagementType.all) {
      buffer.writeln("""
  getIt.registerSingleton<${capitalizedCategory}Notifier>(
    ${capitalizedCategory}Notifier(
      repository: getIt<${capitalizedCategory}Repository>(),
    ),
  );
""");
    }

    buffer.writeln("}");

    file.writeAsStringSync(buffer.toString());
  }

  /// Generates the main `injection.dart` file.
  ///
  /// - Imports all module-specific injection files.
  /// - Exposes a global [GetIt] instance named [getIt].
  /// - Provides [initInjection] function to initialize all modules.
  void _generateMainInjection() {
    String filePath =
        '${mainPath.contains("example") ? "example/" : ""}lib/common/injection/injection.dart';
    final file = File(filePath);
    file.parent.createSync(recursive: true);
    final StringBuffer buffer = StringBuffer();

    buffer.writeln("import 'package:get_it/get_it.dart';");

    for (var module in moduleList) {
      buffer.writeln("import 'src/${module.toSnakeCase()}_injection.dart';");
    }

    buffer.writeln("""
final GetIt getIt = GetIt.instance;

/// Initializes dependency injection for all modules.
Future<void> initInjection() async {
${moduleList.map((module) => "  await ${module}Injection();").join(line)}
}
""");

    file.writeAsStringSync(buffer.toString());
  }
}
