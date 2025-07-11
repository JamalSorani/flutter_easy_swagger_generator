import 'package:either_dart/either.dart';
import '../domain/repository/package_repository.dart';
import '../infrastructure/models/package_get_all_model.dart';
import '../infrastructure/models/package_get_by_id_model.dart';
import '../domain/entities/package_get_all_param.dart';
import '../domain/entities/package_get_by_id_param.dart';

class PackageFacade {
  final PackageRepository _repository;
  PackageFacade({required PackageRepository repository})
      : _repository = repository;
  Future<Either<String, PackageGetAllModel>> packageGetAll({
    required PackageGetAllParam packageGetAllParam,
  }) =>
      _repository.packageGetAll(packageGetAllParam: packageGetAllParam);

  Future<Either<String, PackageGetByIdModel>> packageGetById({
    required PackageGetByIdParam packageGetByIdParam,
  }) =>
      _repository.packageGetById(packageGetByIdParam: packageGetByIdParam);

}
