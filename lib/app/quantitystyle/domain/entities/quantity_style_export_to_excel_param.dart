
import 'export_quantity_styles_to_excel_query.dart';
class QuantityStyleExportToExcelParam {
  final ExportQuantityStylesToExcelQuery exportQuantityStylesToExcelQuery;
  QuantityStyleExportToExcelParam({required this.exportQuantityStylesToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportQuantityStylesToExcelQuery.toJson();
          }    
        }
          