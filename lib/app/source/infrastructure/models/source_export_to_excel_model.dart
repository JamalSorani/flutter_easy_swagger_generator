
import 'export_sources_to_excel_query_model_model.dart';
class SourceExportToExcelModel {
  final ExportSourcesToExcelQueryModel exportSourcesToExcelQueryModel;
  SourceExportToExcelModel({required this.exportSourcesToExcelQueryModel});
 factory SourceExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return SourceExportToExcelModel(
   exportSourcesToExcelQueryModel:       ExportSourcesToExcelQueryModel.fromJson(json),
          );
        }    
        }
          