
import 'export_products_to_excel_query.dart';
class SalesWindowExportProdductToExcelParam {
  final ExportProductsToExcelQuery exportProductsToExcelQuery;
  SalesWindowExportProdductToExcelParam({required this.exportProductsToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportProductsToExcelQuery.toJson();
          }    
        }
          