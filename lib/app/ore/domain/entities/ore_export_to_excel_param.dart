
import 'export_ores_to_excel_query_param.dart';
class OreExportToExcelParam {
  final ExportOresToExcelQuery exportOresToExcelQuery;
  OreExportToExcelParam({required this.exportOresToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportOresToExcelQuery.toJson();
          }    
        }
          