
import 'get_orders_pdf_query.dart';
class OrderGetOrdersPdfParam {
  final GetOrdersPdfQuery getOrdersPdfQuery;
  OrderGetOrdersPdfParam({required this.getOrdersPdfQuery});
 Map<String, dynamic> toJson() {
    return
          getOrdersPdfQuery.toJson();
          }    
        }
          