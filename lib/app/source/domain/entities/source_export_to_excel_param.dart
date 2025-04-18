
import 'export_sources_to_excel_query_param_param.dart';
class SourceExportToExcelParam {
  final ExportSourcesToExcelQueryParam exportSourcesToExcelQueryParam;
  SourceExportToExcelParam({required this.exportSourcesToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportSourcesToExcelQueryParam.toJson();
          }    
        }
          