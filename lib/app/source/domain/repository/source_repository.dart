import 'package:either_dart/either.dart';
import '../../infrastructure/models/source_get_all_model.dart';
import '../../infrastructure/models/source_upsert_model.dart';
import '../../infrastructure/models/source_delete_model.dart';
import '../../infrastructure/models/source_export_to_excel_model.dart';
import '../../infrastructure/models/source_get_pdf_model.dart';
import '../entities/source_get_all_param.dart';
import '../entities/source_upsert_param.dart';
import '../entities/source_delete_param.dart';
import '../entities/source_export_to_excel_param.dart';
import '../entities/source_get_pdf_param.dart';

abstract class SourceRepository {
  Future<Either<String, SourceGetAllModel>> sourceGetAll({required SourceGetAllParam sourceGetAllParam});

  Future<Either<String, SourceUpsertModel>> sourceUpsert({required SourceUpsertParam sourceUpsertParam});

  Future<Either<String, SourceDeleteModel>> sourceDelete({required SourceDeleteParam sourceDeleteParam});

  Future<Either<String, SourceExportToExcelModel>> sourceExportToExcel({required SourceExportToExcelParam sourceExportToExcelParam});

  Future<Either<String, SourceGetPdfModel>> sourceGetPdf({required SourceGetPdfParam sourceGetPdfParam});

}
