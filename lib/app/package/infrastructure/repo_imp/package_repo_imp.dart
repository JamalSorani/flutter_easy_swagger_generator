import 'package:either_dart/either.dart';
import '../../domain/repository/package_repository.dart';
import '../../../../common/network/exception/error_handler.dart';
import '../datasource/remote/package_remote.dart';
import '../models/package_get_all_model.dart';
import '../models/package_get_by_id_model.dart';
import '../../domain/entities/package_get_all_param.dart';
import '../../domain/entities/package_get_by_id_param.dart';

class PackageRepoImp implements PackageRepository {
  final PackageApi _remote;
  PackageRepoImp({required PackageApi api}) : _remote = api;

  @override
  Future<Either<String, PackageGetAllModel>> packageGetAll({
    required PackageGetAllParam packageGetAllParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.packageGetAll(
        packageGetAllParam: packageGetAllParam,
      );
      return response;
    });
  }

  @override
  Future<Either<String, PackageGetByIdModel>> packageGetById({
    required PackageGetByIdParam packageGetByIdParam,
  }) {
    return throwAppException(() async {
      final response = await _remote.packageGetById(
        packageGetByIdParam: packageGetByIdParam,
      );
      return response;
    });
  }
}
