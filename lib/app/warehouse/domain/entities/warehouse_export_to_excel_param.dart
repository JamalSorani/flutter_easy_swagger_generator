
import 'export_warehouses_to_excel_query.dart';
class WarehouseExportToExcelParam {
  final ExportWarehousesToExcelQuery exportWarehousesToExcelQuery;
  WarehouseExportToExcelParam({required this.exportWarehousesToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportWarehousesToExcelQuery.toJson();
          }    
        }
          