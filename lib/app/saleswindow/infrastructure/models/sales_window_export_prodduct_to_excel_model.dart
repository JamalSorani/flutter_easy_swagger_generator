
import 'export_products_to_excel_query_model_model.dart';
class SalesWindowExportProdductToExcelModel {
  final ExportProductsToExcelQueryModel exportProductsToExcelQueryModel;
  SalesWindowExportProdductToExcelModel({required this.exportProductsToExcelQueryModel});
 factory SalesWindowExportProdductToExcelModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowExportProdductToExcelModel(
   exportProductsToExcelQueryModel:       ExportProductsToExcelQueryModel.fromJson(json),
          );
        }    
        }
          