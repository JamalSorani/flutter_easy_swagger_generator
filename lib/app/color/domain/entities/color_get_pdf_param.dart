
import 'get_colors_pdf_query.dart';
class ColorGetPdfParam {
  final GetColorsPdfQuery getColorsPdfQuery;
  ColorGetPdfParam({required this.getColorsPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getColorsPdfQuery.toJson();
          }    
        }
          