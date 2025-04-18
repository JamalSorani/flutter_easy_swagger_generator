
import 'export_sources_to_excel_query_param.dart';
class SourceExportToExcelParam {
  final ExportSourcesToExcelQuery exportSourcesToExcelQuery;
  SourceExportToExcelParam({required this.exportSourcesToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportSourcesToExcelQuery.toJson();
          }    
        }
          