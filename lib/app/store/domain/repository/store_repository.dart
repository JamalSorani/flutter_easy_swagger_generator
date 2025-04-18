import 'package:either_dart/either.dart';
import '../../infrastructure/models/store_get_all_model.dart';
import '../../infrastructure/models/store_upsert_model.dart';
import '../../infrastructure/models/store_delete_model.dart';
import '../../infrastructure/models/store_export_to_excel_model.dart';
import '../../infrastructure/models/store_get_pdf_model.dart';
import '../entities/store_get_all_param.dart';
import '../entities/store_upsert_param.dart';
import '../entities/store_delete_param.dart';
import '../entities/store_export_to_excel_param.dart';
import '../entities/store_get_pdf_param.dart';

abstract class StoreRepository {
  Future<Either<String, StoreGetAllModel>> storeGetAll({required StoreGetAllParam storeGetAllParam});

  Future<Either<String, StoreUpsertModel>> storeUpsert({required StoreUpsertParam storeUpsertParam});

  Future<Either<String, StoreDeleteModel>> storeDelete({required StoreDeleteParam storeDeleteParam});

  Future<Either<String, StoreExportToExcelModel>> storeExportToExcel({required StoreExportToExcelParam storeExportToExcelParam});

  Future<Either<String, StoreGetPdfModel>> storeGetPdf({required StoreGetPdfParam storeGetPdfParam});

}
