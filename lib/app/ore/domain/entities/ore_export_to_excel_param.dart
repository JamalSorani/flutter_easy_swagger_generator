
import 'export_ores_to_excel_query_param_param.dart';
class OreExportToExcelParam {
  final ExportOresToExcelQueryParam exportOresToExcelQueryParam;
  OreExportToExcelParam({required this.exportOresToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportOresToExcelQueryParam.toJson();
          }    
        }
          