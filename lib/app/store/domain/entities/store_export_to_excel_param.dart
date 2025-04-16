
import 'export_stores_to_excel_query.dart';
class StoreExportToExcelParam {
  final ExportStoresToExcelQuery exportStoresToExcelQuery;
  StoreExportToExcelParam({required this.exportStoresToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportStoresToExcelQuery.toJson();
          }    
        }
          