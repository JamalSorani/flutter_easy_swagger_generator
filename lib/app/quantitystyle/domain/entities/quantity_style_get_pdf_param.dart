
import 'get_quantity_styles_pdf_query_param.dart';
class QuantityStyleGetPdfParam {
  final GetQuantityStylesPdfQuery getQuantityStylesPdfQuery;
  QuantityStyleGetPdfParam({required this.getQuantityStylesPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getQuantityStylesPdfQuery.toJson();
          }    
        }
          