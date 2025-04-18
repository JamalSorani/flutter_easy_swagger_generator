
import 'export_sales_windows_to_excel_query_param_param.dart';
class SalesWindowExportToExcelParam {
  final ExportSalesWindowsToExcelQueryParam exportSalesWindowsToExcelQueryParam;
  SalesWindowExportToExcelParam({required this.exportSalesWindowsToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportSalesWindowsToExcelQueryParam.toJson();
          }    
        }
          