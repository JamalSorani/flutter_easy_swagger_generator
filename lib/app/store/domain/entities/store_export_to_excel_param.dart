
import 'export_stores_to_excel_query_param_param.dart';
class StoreExportToExcelParam {
  final ExportStoresToExcelQueryParam exportStoresToExcelQueryParam;
  StoreExportToExcelParam({required this.exportStoresToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportStoresToExcelQueryParam.toJson();
          }    
        }
          