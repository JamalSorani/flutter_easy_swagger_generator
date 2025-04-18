
import 'export_customers_to_excel_query_param.dart';
class CustomerExportToExcelParam {
  final ExportCustomersToExcelQuery exportCustomersToExcelQuery;
  CustomerExportToExcelParam({required this.exportCustomersToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportCustomersToExcelQuery.toJson();
          }    
        }
          