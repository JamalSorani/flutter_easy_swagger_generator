import 'package:flutter_easy_swagger_generator/helpers/import_path.dart';
import 'package:flutter_easy_swagger_generator/helpers/imports.dart';

class FilePath {
  final String mainPath;
  final String category;
  final String? routeName;
  final bool isMVVM;
  FilePath({
    required this.mainPath,
    required this.category,
    this.routeName,
    required this.isMVVM,
  });

  String get applicationFilePath {
    return '$mainPath/$category/application/${category}_facade.dart';
  }

  String get entityFilePath {
    return '$mainPath/$category/${ImportPath(
      isMVVM: isMVVM,
      actionName: routeName!,
    ).entityFilePath}';
  }

  String get modelFilePath {
    return '$mainPath/$category/${ImportPath(
      isMVVM: isMVVM,
      actionName: routeName!,
    ).modelFilePath}';
  }

  String get repositoryFilePath {
    final subPath = isMVVM ? 'data/repositories' : 'domain/repository';
    return '$mainPath/$category/$subPath/${category}_repository.dart';
  }

  String get remoteFilePath {
    final subPath = isMVVM ? "data" : "infrastructure/datasource";
    return '$mainPath/$category/$subPath/remote/${category}_remote.dart';
  }

  String get repoImpFilePath {
    final subPath = isMVVM ? "data/repositories" : "infrastructure/repo_imp";
    return '$mainPath/$category/$subPath/${category}_repo_imp.dart';
  }

  String get blocFilePath {
    return '$mainPath/$category/presentation/state/bloc/${category}_bloc.dart';
  }

  String get eventFilePath {
    return '$mainPath/$category/presentation/state/bloc/${category}_event.dart';
  }

  String get stateFilePath {
    return '$mainPath/$category/presentation/state/bloc/${category}_state.dart';
  }

  String get providerFilePath {
    final subPath = isMVVM ? "viewmodels" : "presentation/state/provider";
    final nameComplement = isMVVM ? "view_model" : "provider";
    return '$mainPath/$category/$subPath/${category}_$nameComplement.dart';
  }

  String get riverpodFilePath {
    return '$mainPath/$category/presentation/state/riverpod/${category}_riverpod.dart';
  }
}
