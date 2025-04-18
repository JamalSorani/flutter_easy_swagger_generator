
import 'export_orders_to_excel_query_param_param.dart';
class OrderExportToExcelParam {
  final ExportOrdersToExcelQueryParam exportOrdersToExcelQueryParam;
  OrderExportToExcelParam({required this.exportOrdersToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportOrdersToExcelQueryParam.toJson();
          }    
        }
          