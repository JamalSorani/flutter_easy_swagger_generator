
import 'export_stores_to_excel_query_model_model.dart';
class StoreExportToExcelModel {
  final ExportStoresToExcelQueryModel exportStoresToExcelQueryModel;
  StoreExportToExcelModel({required this.exportStoresToExcelQueryModel});
 factory StoreExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return StoreExportToExcelModel(
   exportStoresToExcelQueryModel:       exportStoresToExcelQueryModel.fromJson(json),
          );
        }    
        }
          