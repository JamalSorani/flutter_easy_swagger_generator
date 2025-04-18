
import 'get_sources_pdf_query_param_param.dart';
class SourceGetPdfParam {
  final GetSourcesPdfQueryParam getSourcesPdfQueryParam;
  SourceGetPdfParam({required this.getSourcesPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getSourcesPdfQueryParam.toJson();
          }    
        }
          