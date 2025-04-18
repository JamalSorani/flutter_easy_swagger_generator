
import 'get_ores_pdf_query_param.dart';
class OreGetPdfParam {
  final GetOresPdfQuery getOresPdfQuery;
  OreGetPdfParam({required this.getOresPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getOresPdfQuery.toJson();
          }    
        }
          