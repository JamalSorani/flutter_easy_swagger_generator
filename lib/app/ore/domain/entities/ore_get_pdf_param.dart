
import 'get_ores_pdf_query_param_param.dart';
class OreGetPdfParam {
  final GetOresPdfQueryParam getOresPdfQueryParam;
  OreGetPdfParam({required this.getOresPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getOresPdfQueryParam.toJson();
          }    
        }
          