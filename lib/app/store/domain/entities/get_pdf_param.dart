
import 'get_stores_pdf_query_param.dart';
class StoreGetPdfParam {
  final GetStoresPdfQuery getStoresPdfQuery;
  StoreGetPdfParam({required this.getStoresPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getStoresPdfQuery.toJson();
          }    
        }
          