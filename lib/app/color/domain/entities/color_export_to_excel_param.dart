
import 'export_colors_to_excel_query_param_param.dart';
class ColorExportToExcelParam {
  final ExportColorsToExcelQueryParam exportColorsToExcelQueryParam;
  ColorExportToExcelParam({required this.exportColorsToExcelQueryParam});
 Map<String, dynamic> toJson() {
    return
          exportColorsToExcelQueryParam.toJson();
          }    
        }
          