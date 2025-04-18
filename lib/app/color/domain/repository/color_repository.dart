import 'package:either_dart/either.dart';
import '../../infrastructure/models/color_get_all_model.dart';
import '../../infrastructure/models/color_upsert_model.dart';
import '../../infrastructure/models/color_delete_model.dart';
import '../../infrastructure/models/color_export_to_excel_model.dart';
import '../../infrastructure/models/color_get_pdf_model.dart';
import '../entities/color_get_all_param.dart';
import '../entities/color_upsert_param.dart';
import '../entities/color_delete_param.dart';
import '../entities/color_export_to_excel_param.dart';
import '../entities/color_get_pdf_param.dart';

abstract class ColorRepository {
  Future<Either<String, ColorGetAllModel>> colorGetAll({required ColorGetAllParam colorGetAllParam});

  Future<Either<String, ColorUpsertModel>> colorUpsert({required ColorUpsertParam colorUpsertParam});

  Future<Either<String, ColorDeleteModel>> colorDelete({required ColorDeleteParam colorDeleteParam});

  Future<Either<String, ColorExportToExcelModel>> colorExportToExcel({required ColorExportToExcelParam colorExportToExcelParam});

  Future<Either<String, ColorGetPdfModel>> colorGetPdf({required ColorGetPdfParam colorGetPdfParam});

}
