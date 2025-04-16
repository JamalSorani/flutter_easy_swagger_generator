
import 'export_products_to_excel_query.dart';
class ProductExportToExcelParam {
  final ExportProductsToExcelQuery exportProductsToExcelQuery;
  ProductExportToExcelParam({required this.exportProductsToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportProductsToExcelQuery.toJson();
          }    
        }
          