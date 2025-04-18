
import 'export_customers_to_excel_query_param_param.dart';
class CustomerExportToExcelParam {
  final ExportCustomersToExcelQueryParam exportCustomersToExcelQueryParam;
  CustomerExportToExcelParam({required this.exportCustomersToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportCustomersToExcelQueryParam.toJson();
          }    
        }
          