
import 'export_stocks_to_excel_query_model_model.dart';
class InventoryManagmentExportStocksToExcelModel {
  final ExportStocksToExcelQueryModel exportStocksToExcelQueryModel;
  InventoryManagmentExportStocksToExcelModel({required this.exportStocksToExcelQueryModel});
 factory InventoryManagmentExportStocksToExcelModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentExportStocksToExcelModel(
   exportStocksToExcelQueryModel:       ExportStocksToExcelQueryModel.fromJson(json),
          );
        }    
        }
          