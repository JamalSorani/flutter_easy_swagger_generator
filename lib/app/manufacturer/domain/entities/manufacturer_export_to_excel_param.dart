
import 'export_manufacturers_to_excel_query_param_param.dart';
class ManufacturerExportToExcelParam {
  final ExportManufacturersToExcelQueryParam exportManufacturersToExcelQueryParam;
  ManufacturerExportToExcelParam({required this.exportManufacturersToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportManufacturersToExcelQueryParam.toJson();
          }    
        }
          