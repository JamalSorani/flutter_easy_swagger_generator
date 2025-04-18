import 'package:either_dart/either.dart';
import '../../infrastructure/models/quantity_style_get_all_model.dart';
import '../../infrastructure/models/quantity_style_upsert_model.dart';
import '../../infrastructure/models/quantity_style_delete_model.dart';
import '../../infrastructure/models/quantity_style_export_to_excel_model.dart';
import '../../infrastructure/models/quantity_style_get_pdf_model.dart';
import '../entities/quantity_style_get_all_param.dart';
import '../entities/quantity_style_upsert_param.dart';
import '../entities/quantity_style_delete_param.dart';
import '../entities/quantity_style_export_to_excel_param.dart';
import '../entities/quantity_style_get_pdf_param.dart';

abstract class QuantitystyleRepository {
  Future<Either<String, QuantityStyleGetAllModel>> quantityStyleGetAll({required QuantityStyleGetAllParam quantityStyleGetAllParam});

  Future<Either<String, QuantityStyleUpsertModel>> quantityStyleUpsert({required QuantityStyleUpsertParam quantityStyleUpsertParam});

  Future<Either<String, QuantityStyleDeleteModel>> quantityStyleDelete({required QuantityStyleDeleteParam quantityStyleDeleteParam});

  Future<Either<String, QuantityStyleExportToExcelModel>> quantityStyleExportToExcel({required QuantityStyleExportToExcelParam quantityStyleExportToExcelParam});

  Future<Either<String, QuantityStyleGetPdfModel>> quantityStyleGetPdf({required QuantityStyleGetPdfParam quantityStyleGetPdfParam});

}
