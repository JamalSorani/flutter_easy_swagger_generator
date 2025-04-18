
import 'export_stocks_to_excel_query_param.dart';
class InventoryManagmentExportStocksToExcelParam {
  final ExportStocksToExcelQuery exportStocksToExcelQuery;
  InventoryManagmentExportStocksToExcelParam({required this.exportStocksToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportStocksToExcelQuery.toJson();
          }    
        }
          