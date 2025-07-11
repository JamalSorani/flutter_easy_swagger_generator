import 'package:dio/dio.dart';
import '../../../../generated_routes.dart';
import '../../../../../common/network/exception/error_handler.dart';
import '../../models/package_get_all_model.dart';
import '../../models/package_get_by_id_model.dart';
import '../../../domain/entities/package_get_all_param.dart';
import '../../../domain/entities/package_get_by_id_param.dart';

class PackageApi {
  final Dio _dio;
  const PackageApi(Dio dio) : _dio = dio;
  Future<PackageGetAllModel> packageGetAll({
    required PackageGetAllParam packageGetAllParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.get(
        AppUrl.packageGetAll,
        data: packageGetAllParam.toJson(),
      );
      return PackageGetAllModel.fromJson(response.data);
    });
  }

  Future<PackageGetByIdModel> packageGetById({
    required PackageGetByIdParam packageGetByIdParam,
  }) {
    return throwDioException(() async {
      final response = await _dio.get(
        AppUrl.packageGetById,
        data: packageGetByIdParam.toJson(),
      );
      return PackageGetByIdModel.fromJson(response.data);
    });
  }

}
