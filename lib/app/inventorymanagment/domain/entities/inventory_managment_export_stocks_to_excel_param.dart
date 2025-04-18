
import 'export_stocks_to_excel_query_param_param.dart';
class InventoryManagmentExportStocksToExcelParam {
  final ExportStocksToExcelQueryParam exportStocksToExcelQueryParam;
  InventoryManagmentExportStocksToExcelParam({required this.exportStocksToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportStocksToExcelQueryParam.toJson();
          }    
        }
          