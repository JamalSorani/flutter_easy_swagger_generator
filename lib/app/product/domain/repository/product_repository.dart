import 'package:either_dart/either.dart';
import '../../infrastructure/models/product_get_all_model.dart';
import '../../infrastructure/models/product_get_by_qr_model.dart';
import '../../infrastructure/models/product_add_model.dart';
import '../../infrastructure/models/product_modify_model.dart';
import '../../infrastructure/models/product_get_by_id_model.dart';
import '../../infrastructure/models/product_delete_model.dart';
import '../../infrastructure/models/product_get_all_names_model.dart';
import '../../infrastructure/models/product_get_similar_model.dart';
import '../../infrastructure/models/product_get_pdf_model.dart';
import '../../infrastructure/models/product_export_to_excel_model.dart';
import '../entities/product_get_all_param.dart';
import '../entities/product_get_by_qr_param.dart';
import '../entities/product_add_param.dart';
import '../entities/product_modify_param.dart';
import '../entities/product_get_by_id_param.dart';
import '../entities/product_delete_param.dart';
import '../entities/product_get_all_names_param.dart';
import '../entities/product_get_similar_param.dart';
import '../entities/product_get_pdf_param.dart';
import '../entities/product_export_to_excel_param.dart';

abstract class ProductRepository {
  Future<Either<String, ProductGetAllModel>> productGetAll({required ProductGetAllParam productGetAllParam});

  Future<Either<String, ProductGetByQRModel>> productGetByQR({required ProductGetByQRParam productGetByQRParam});

  Future<Either<String, ProductAddModel>> productAdd({required ProductAddParam productAddParam});

  Future<Either<String, ProductModifyModel>> productModify({required ProductModifyParam productModifyParam});

  Future<Either<String, ProductGetByIdModel>> productGetById({required ProductGetByIdParam productGetByIdParam});

  Future<Either<String, ProductDeleteModel>> productDelete({required ProductDeleteParam productDeleteParam});

  Future<Either<String, ProductGetAllNamesModel>> productGetAllNames({required ProductGetAllNamesParam productGetAllNamesParam});

  Future<Either<String, ProductGetSimilarModel>> productGetSimilar({required ProductGetSimilarParam productGetSimilarParam});

  Future<Either<String, ProductGetPdfModel>> productGetPdf({required ProductGetPdfParam productGetPdfParam});

  Future<Either<String, ProductExportToExcelModel>> productExportToExcel({required ProductExportToExcelParam productExportToExcelParam});

}
