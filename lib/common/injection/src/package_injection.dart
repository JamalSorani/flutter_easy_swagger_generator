import 'package:dio/dio.dart';
import '../../../app/package/application/package_facade.dart';
import '../../../app/package/domain/repository/package_repository.dart';
import '../../../app/package/infrastructure/datasource/remote/package_remote.dart';
import '../../../app/package/infrastructure/repo_imp/package_repo_imp.dart';
import '../../../app/package/presentation/state/package_bloc.dart';
import '../injection.dart';

Future<void> packageInjection() async {
  getIt.registerSingleton<PackageApi>(
    PackageApi(
      getIt<Dio>(),
    ),
  );

  getIt.registerSingleton<PackageRepository>(
    PackageRepoImp(
      api: getIt<PackageApi>(),
    ),
  );

  getIt.registerSingleton<PackageFacade>(
    PackageFacade(
      repository: getIt<PackageRepository>(),
    ),
  );

  getIt.registerSingleton<PackageBloc>(
    PackageBloc(
      facade: getIt<PackageFacade>(),
    ),
  );
}
