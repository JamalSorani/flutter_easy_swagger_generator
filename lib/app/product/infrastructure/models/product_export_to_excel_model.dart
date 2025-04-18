
import 'export_products_to_excel_query_model_model.dart';
class ProductExportToExcelModel {
  final ExportProductsToExcelQueryModel exportProductsToExcelQueryModel;
  ProductExportToExcelModel({required this.exportProductsToExcelQueryModel});
 factory ProductExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return ProductExportToExcelModel(
   exportProductsToExcelQueryModel:       ExportProductsToExcelQueryModel.fromJson(json),
          );
        }    
        }
          