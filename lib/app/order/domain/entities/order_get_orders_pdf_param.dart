
import 'get_orders_pdf_query_param.dart';
class OrderGetOrdersPdfParam {
  final GetOrdersPdfQuery getOrdersPdfQuery;
  OrderGetOrdersPdfParam({required this.getOrdersPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getOrdersPdfQuery.toJson();
          }    
        }
          