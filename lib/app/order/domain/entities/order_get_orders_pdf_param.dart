
import 'get_orders_pdf_query_param_param.dart';
class OrderGetOrdersPdfParam {
  final GetOrdersPdfQueryParam getOrdersPdfQueryParam;
  OrderGetOrdersPdfParam({required this.getOrdersPdfQueryParam});
 Map<String, dynamic> toJson() {
    return
          getOrdersPdfQueryParam.toJson();
          }    
        }
          