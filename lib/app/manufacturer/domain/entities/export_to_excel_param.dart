
import 'export_manufacturers_to_excel_query_param.dart';
class ManufacturerExportToExcelParam {
  final ExportManufacturersToExcelQuery exportManufacturersToExcelQuery;
  ManufacturerExportToExcelParam({required this.exportManufacturersToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportManufacturersToExcelQuery.toJson();
          }    
        }
          