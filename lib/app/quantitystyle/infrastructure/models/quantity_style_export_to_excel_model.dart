
import 'export_quantity_styles_to_excel_query_model_model.dart';
class QuantityStyleExportToExcelModel {
  final ExportQuantityStylesToExcelQueryModel exportQuantityStylesToExcelQueryModel;
  QuantityStyleExportToExcelModel({required this.exportQuantityStylesToExcelQueryModel});
 factory QuantityStyleExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return QuantityStyleExportToExcelModel(
   exportQuantityStylesToExcelQueryModel:       exportQuantityStylesToExcelQueryModel.fromJson(json),
          );
        }    
        }
          