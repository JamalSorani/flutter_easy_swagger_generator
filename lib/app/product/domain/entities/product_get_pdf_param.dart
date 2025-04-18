
import 'get_products_pdf_query_param.dart';
class ProductGetPdfParam {
  final GetProductsPdfQuery getProductsPdfQuery;
  ProductGetPdfParam({required this.getProductsPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getProductsPdfQuery.toJson();
          }    
        }
          