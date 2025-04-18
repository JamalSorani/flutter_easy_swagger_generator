
import 'export_warehouses_to_excel_query_param_param.dart';
class WarehouseExportToExcelParam {
  final ExportWarehousesToExcelQueryParam exportWarehousesToExcelQueryParam;
  WarehouseExportToExcelParam({required this.exportWarehousesToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportWarehousesToExcelQueryParam.toJson();
          }    
        }
          