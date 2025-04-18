
import 'get_sources_pdf_query_param.dart';
class SourceGetPdfParam {
  final GetSourcesPdfQuery getSourcesPdfQuery;
  SourceGetPdfParam({required this.getSourcesPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getSourcesPdfQuery.toJson();
          }    
        }
          