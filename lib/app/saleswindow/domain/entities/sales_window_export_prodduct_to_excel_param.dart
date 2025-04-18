
import 'export_products_to_excel_query_param_param.dart';
class SalesWindowExportProdductToExcelParam {
  final ExportProductsToExcelQueryParam exportProductsToExcelQueryParam;
  SalesWindowExportProdductToExcelParam({required this.exportProductsToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportProductsToExcelQueryParam.toJson();
          }    
        }
          