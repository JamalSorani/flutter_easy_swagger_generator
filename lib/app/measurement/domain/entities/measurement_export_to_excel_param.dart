
import 'export_measurements_to_excel_query_param_param.dart';
class MeasurementExportToExcelParam {
  final ExportMeasurementsToExcelQueryParam exportMeasurementsToExcelQueryParam;
  MeasurementExportToExcelParam({required this.exportMeasurementsToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportMeasurementsToExcelQueryParam.toJson();
          }    
        }
          