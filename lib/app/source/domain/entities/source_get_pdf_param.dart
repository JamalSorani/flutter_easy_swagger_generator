
import 'get_sources_pdf_query.dart';
class SourceGetPdfParam {
  final GetSourcesPdfQuery getSourcesPdfQuery;
  SourceGetPdfParam({required this.getSourcesPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getSourcesPdfQuery.toJson();
          }    
        }
          