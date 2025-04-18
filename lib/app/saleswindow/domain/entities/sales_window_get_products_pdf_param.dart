
import 'get_products_to_pdf_query_param_param.dart';
class SalesWindowGetProductsPdfParam {
  final GetProductsToPdfQueryParam getProductsToPdfQueryParam;
  SalesWindowGetProductsPdfParam({required this.getProductsToPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getProductsToPdfQueryParam.toJson();
          }    
        }
          