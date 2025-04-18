
import 'export_products_to_excel_query_param.dart';
class WarehouseExportProdductToExcelParam {
  final ExportProductsToExcelQuery exportProductsToExcelQuery;
  WarehouseExportProdductToExcelParam({required this.exportProductsToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportProductsToExcelQuery.toJson();
          }    
        }
          