
import 'export_orders_to_excel_query_param.dart';
class OrderExportToExcelParam {
  final ExportOrdersToExcelQuery exportOrdersToExcelQuery;
  OrderExportToExcelParam({required this.exportOrdersToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportOrdersToExcelQuery.toJson();
          }    
        }
          