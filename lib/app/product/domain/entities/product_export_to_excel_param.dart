
import 'export_products_to_excel_query_param_param.dart';
class ProductExportToExcelParam {
  final ExportProductsToExcelQueryParam exportProductsToExcelQueryParam;
  ProductExportToExcelParam({required this.exportProductsToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportProductsToExcelQueryParam.toJson();
          }    
        }
          