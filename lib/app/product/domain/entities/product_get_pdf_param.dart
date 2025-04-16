
import 'get_products_pdf_query.dart';
class ProductGetPdfParam {
  final GetProductsPdfQuery getProductsPdfQuery;
  ProductGetPdfParam({required this.getProductsPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getProductsPdfQuery.toJson();
          }    
        }
          