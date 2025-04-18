
import 'get_orders_pdf_query_model_model.dart';
class OrderGetOrdersPdfModel {
  final GetOrdersPdfQueryModel getOrdersPdfQueryModel;
  OrderGetOrdersPdfModel({required this.getOrdersPdfQueryModel});
 factory OrderGetOrdersPdfModel.fromJson(Map<String, dynamic> json) {
    return OrderGetOrdersPdfModel(
   getOrdersPdfQueryModel:       GetOrdersPdfQueryModel.fromJson(json),
          );
        }    
        }
          