import 'package:either_dart/either.dart';
import '../../infrastructure/models/measurement_get_all_model.dart';
import '../../infrastructure/models/measurement_upsert_model.dart';
import '../../infrastructure/models/measurement_delete_model.dart';
import '../../infrastructure/models/measurement_export_to_excel_model.dart';
import '../../infrastructure/models/measurement_get_pdf_model.dart';
import '../entities/measurement_get_all_param.dart';
import '../entities/measurement_upsert_param.dart';
import '../entities/measurement_delete_param.dart';
import '../entities/measurement_export_to_excel_param.dart';
import '../entities/measurement_get_pdf_param.dart';

abstract class MeasurementRepository {
  Future<Either<String, MeasurementGetAllModel>> measurementGetAll({required MeasurementGetAllParam measurementGetAllParam});

  Future<Either<String, MeasurementUpsertModel>> measurementUpsert({required MeasurementUpsertParam measurementUpsertParam});

  Future<Either<String, MeasurementDeleteModel>> measurementDelete({required MeasurementDeleteParam measurementDeleteParam});

  Future<Either<String, MeasurementExportToExcelModel>> measurementExportToExcel({required MeasurementExportToExcelParam measurementExportToExcelParam});

  Future<Either<String, MeasurementGetPdfModel>> measurementGetPdf({required MeasurementGetPdfParam measurementGetPdfParam});

}
