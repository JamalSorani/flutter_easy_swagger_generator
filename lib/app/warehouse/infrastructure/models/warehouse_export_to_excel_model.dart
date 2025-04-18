
import 'export_warehouses_to_excel_query_model_model.dart';
class WarehouseExportToExcelModel {
  final ExportWarehousesToExcelQueryModel exportWarehousesToExcelQueryModel;
  WarehouseExportToExcelModel({required this.exportWarehousesToExcelQueryModel});
 factory WarehouseExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return WarehouseExportToExcelModel(
   exportWarehousesToExcelQueryModel:       exportWarehousesToExcelQueryModel.fromJson(json),
          );
        }    
        }
          