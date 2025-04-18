
import 'export_measurements_to_excel_query_model_model.dart';
class MeasurementExportToExcelModel {
  final ExportMeasurementsToExcelQueryModel exportMeasurementsToExcelQueryModel;
  MeasurementExportToExcelModel({required this.exportMeasurementsToExcelQueryModel});
 factory MeasurementExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return MeasurementExportToExcelModel(
   exportMeasurementsToExcelQueryModel:       exportMeasurementsToExcelQueryModel.fromJson(json),
          );
        }    
        }
          