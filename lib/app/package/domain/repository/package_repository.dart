import 'package:either_dart/either.dart';
import '../../infrastructure/models/package_get_all_model.dart';
import '../../infrastructure/models/package_get_by_id_model.dart';
import '../../infrastructure/models/package_get_all_products_model.dart';
import '../../infrastructure/models/package_add_model.dart';
import '../../infrastructure/models/package_modify_model.dart';
import '../../infrastructure/models/package_delete_model.dart';
import '../../infrastructure/models/package_get_similar_model.dart';
import '../../infrastructure/models/package_get_pdf_model.dart';
import '../../infrastructure/models/package_export_to_excel_model.dart';
import '../entities/package_get_all_param.dart';
import '../entities/package_get_by_id_param.dart';
import '../entities/package_get_all_products_param.dart';
import '../entities/package_add_param.dart';
import '../entities/package_modify_param.dart';
import '../entities/package_delete_param.dart';
import '../entities/package_get_similar_param.dart';
import '../entities/package_get_pdf_param.dart';
import '../entities/package_export_to_excel_param.dart';

abstract class PackageRepository {
  Future<Either<String, PackageGetAllModel>> packageGetAll({required PackageGetAllParam packageGetAllParam});

  Future<Either<String, PackageGetByIdModel>> packageGetById({required PackageGetByIdParam packageGetByIdParam});

  Future<Either<String, PackageGetAllProductsModel>> packageGetAllProducts({required PackageGetAllProductsParam packageGetAllProductsParam});

  Future<Either<String, PackageAddModel>> packageAdd({required PackageAddParam packageAddParam});

  Future<Either<String, PackageModifyModel>> packageModify({required PackageModifyParam packageModifyParam});

  Future<Either<String, PackageDeleteModel>> packageDelete({required PackageDeleteParam packageDeleteParam});

  Future<Either<String, PackageGetSimilarModel>> packageGetSimilar({required PackageGetSimilarParam packageGetSimilarParam});

  Future<Either<String, PackageGetPdfModel>> packageGetPdf({required PackageGetPdfParam packageGetPdfParam});

  Future<Either<String, PackageExportToExcelModel>> packageExportToExcel({required PackageExportToExcelParam packageExportToExcelParam});

}
