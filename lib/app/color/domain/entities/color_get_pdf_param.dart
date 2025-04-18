
import 'get_colors_pdf_query_param_param.dart';
class ColorGetPdfParam {
  final GetColorsPdfQueryParam getColorsPdfQueryParam;
  ColorGetPdfParam({required this.getColorsPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getColorsPdfQueryParam.toJson();
          }    
        }
          