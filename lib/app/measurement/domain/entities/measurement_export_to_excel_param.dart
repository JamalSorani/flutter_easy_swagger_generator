
import 'export_measurements_to_excel_query.dart';
class MeasurementExportToExcelParam {
  final ExportMeasurementsToExcelQuery exportMeasurementsToExcelQuery;
  MeasurementExportToExcelParam({required this.exportMeasurementsToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportMeasurementsToExcelQuery.toJson();
          }    
        }
          