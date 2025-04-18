
import 'export_products_to_excel_query_param_param.dart';
class WarehouseExportProdductToExcelParam {
  final ExportProductsToExcelQueryParam exportProductsToExcelQueryParam;
  WarehouseExportProdductToExcelParam({required this.exportProductsToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportProductsToExcelQueryParam.toJson();
          }    
        }
          