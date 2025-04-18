
import 'get_products_to_pdf_query_param_param.dart';
class WarehouseGetProductsPdfParam {
  final GetProductsToPdfQueryParam getProductsToPdfQueryParam;
  WarehouseGetProductsPdfParam({required this.getProductsToPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getProductsToPdfQueryParam.toJson();
          }    
        }
          