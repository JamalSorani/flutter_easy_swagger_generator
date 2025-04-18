
import 'get_products_pdf_query_param_param.dart';
class ProductGetPdfParam {
  final GetProductsPdfQueryParam getProductsPdfQueryParam;
  ProductGetPdfParam({required this.getProductsPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getProductsPdfQueryParam.toJson();
          }    
        }
          