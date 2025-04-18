import 'package:either_dart/either.dart';
import '../../infrastructure/models/manufacturer_get_all_model.dart';
import '../../infrastructure/models/manufacturer_upsert_model.dart';
import '../../infrastructure/models/manufacturer_delete_model.dart';
import '../../infrastructure/models/manufacturer_export_to_excel_model.dart';
import '../../infrastructure/models/manufacturer_get_pdf_model.dart';
import '../entities/manufacturer_get_all_param.dart';
import '../entities/manufacturer_upsert_param.dart';
import '../entities/manufacturer_delete_param.dart';
import '../entities/manufacturer_export_to_excel_param.dart';
import '../entities/manufacturer_get_pdf_param.dart';

abstract class ManufacturerRepository {
  Future<Either<String, ManufacturerGetAllModel>> manufacturerGetAll({required ManufacturerGetAllParam manufacturerGetAllParam});

  Future<Either<String, ManufacturerUpsertModel>> manufacturerUpsert({required ManufacturerUpsertParam manufacturerUpsertParam});

  Future<Either<String, ManufacturerDeleteModel>> manufacturerDelete({required ManufacturerDeleteParam manufacturerDeleteParam});

  Future<Either<String, ManufacturerExportToExcelModel>> manufacturerExportToExcel({required ManufacturerExportToExcelParam manufacturerExportToExcelParam});

  Future<Either<String, ManufacturerGetPdfModel>> manufacturerGetPdf({required ManufacturerGetPdfParam manufacturerGetPdfParam});

}
