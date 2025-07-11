import 'package:either_dart/either.dart';
import '../../infrastructure/models/package_get_all_model.dart';
import '../../infrastructure/models/package_get_by_id_model.dart';
import '../entities/package_get_all_param.dart';
import '../entities/package_get_by_id_param.dart';

abstract class PackageRepository {
  Future<Either<String, PackageGetAllModel>> packageGetAll({
    required PackageGetAllParam packageGetAllParam,
  });
  Future<Either<String, PackageGetByIdModel>> packageGetById({
    required PackageGetByIdParam packageGetByIdParam,
  });
}
