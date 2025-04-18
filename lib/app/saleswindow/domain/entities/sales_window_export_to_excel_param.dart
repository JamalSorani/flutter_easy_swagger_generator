
import 'export_sales_windows_to_excel_query_param.dart';
class SalesWindowExportToExcelParam {
  final ExportSalesWindowsToExcelQuery exportSalesWindowsToExcelQuery;
  SalesWindowExportToExcelParam({required this.exportSalesWindowsToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportSalesWindowsToExcelQuery.toJson();
          }    
        }
          