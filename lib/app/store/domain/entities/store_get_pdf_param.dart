
import 'get_stores_pdf_query_param_param.dart';
class StoreGetPdfParam {
  final GetStoresPdfQueryParam getStoresPdfQueryParam;
  StoreGetPdfParam({required this.getStoresPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getStoresPdfQueryParam.toJson();
          }    
        }
          