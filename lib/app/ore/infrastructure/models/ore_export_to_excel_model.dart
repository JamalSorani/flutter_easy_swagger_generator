
import 'export_ores_to_excel_query_model_model.dart';
class OreExportToExcelModel {
  final ExportOresToExcelQueryModel exportOresToExcelQueryModel;
  OreExportToExcelModel({required this.exportOresToExcelQueryModel});
 factory OreExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return OreExportToExcelModel(
   exportOresToExcelQueryModel:       exportOresToExcelQueryModel.fromJson(json),
          );
        }    
        }
          