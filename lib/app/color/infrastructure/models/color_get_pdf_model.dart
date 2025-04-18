
import 'get_colors_pdf_query_model_model.dart';
class ColorGetPdfModel {
  final GetColorsPdfQueryModel getColorsPdfQueryModel;
  ColorGetPdfModel({required this.getColorsPdfQueryModel});
 factory ColorGetPdfModel.fromJson(Map<String, dynamic> json) {
    return ColorGetPdfModel(
   getColorsPdfQueryModel:       getColorsPdfQueryModel.fromJson(json),
          );
        }    
        }
          