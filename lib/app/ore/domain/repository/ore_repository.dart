import 'package:either_dart/either.dart';
import '../../infrastructure/models/ore_get_all_model.dart';
import '../../infrastructure/models/ore_upsert_model.dart';
import '../../infrastructure/models/ore_delete_model.dart';
import '../../infrastructure/models/ore_export_to_excel_model.dart';
import '../../infrastructure/models/ore_get_pdf_model.dart';
import '../entities/ore_get_all_param.dart';
import '../entities/ore_upsert_param.dart';
import '../entities/ore_delete_param.dart';
import '../entities/ore_export_to_excel_param.dart';
import '../entities/ore_get_pdf_param.dart';

abstract class OreRepository {
  Future<Either<String, OreGetAllModel>> oreGetAll({required OreGetAllParam oreGetAllParam});

  Future<Either<String, OreUpsertModel>> oreUpsert({required OreUpsertParam oreUpsertParam});

  Future<Either<String, OreDeleteModel>> oreDelete({required OreDeleteParam oreDeleteParam});

  Future<Either<String, OreExportToExcelModel>> oreExportToExcel({required OreExportToExcelParam oreExportToExcelParam});

  Future<Either<String, OreGetPdfModel>> oreGetPdf({required OreGetPdfParam oreGetPdfParam});

}
