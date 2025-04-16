
import 'get_products_to_pdf_query.dart';
class SalesWindowGetProductsPdfParam {
  final GetProductsToPdfQuery getProductsToPdfQuery;
  SalesWindowGetProductsPdfParam({required this.getProductsToPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getProductsToPdfQuery.toJson();
          }    
        }
          