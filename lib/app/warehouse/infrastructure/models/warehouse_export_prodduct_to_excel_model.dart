
import 'export_products_to_excel_query_model_model.dart';
class WarehouseExportProdductToExcelModel {
  final ExportProductsToExcelQueryModel exportProductsToExcelQueryModel;
  WarehouseExportProdductToExcelModel({required this.exportProductsToExcelQueryModel});
 factory WarehouseExportProdductToExcelModel.fromJson(Map<String, dynamic> json) {
    return WarehouseExportProdductToExcelModel(
   exportProductsToExcelQueryModel:       ExportProductsToExcelQueryModel.fromJson(json),
          );
        }    
        }
          