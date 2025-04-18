
import 'export_colors_to_excel_query_model_model.dart';
class ColorExportToExcelModel {
  final ExportColorsToExcelQueryModel exportColorsToExcelQueryModel;
  ColorExportToExcelModel({required this.exportColorsToExcelQueryModel});
 factory ColorExportToExcelModel.fromJson(Map<String, dynamic> json) {
    return ColorExportToExcelModel(
   exportColorsToExcelQueryModel:       ExportColorsToExcelQueryModel.fromJson(json),
          );
        }    
        }
          