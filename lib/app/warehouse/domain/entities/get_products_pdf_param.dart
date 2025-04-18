
import 'get_products_to_pdf_query_param.dart';
class WarehouseGetProductsPdfParam {
  final GetProductsToPdfQuery getProductsToPdfQuery;
  WarehouseGetProductsPdfParam({required this.getProductsToPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getProductsToPdfQuery.toJson();
          }    
        }
          