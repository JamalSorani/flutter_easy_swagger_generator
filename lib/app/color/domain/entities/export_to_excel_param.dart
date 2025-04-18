
import 'export_colors_to_excel_query_param.dart';
class ColorExportToExcelParam {
  final ExportColorsToExcelQuery exportColorsToExcelQuery;
  ColorExportToExcelParam({required this.exportColorsToExcelQuery});
 Map<String, dynamic> toJson() {
    return
          exportColorsToExcelQuery.toJson();
          }    
        }
          