
import 'change_order_status_command_model_model.dart';
class OrderChangeStatusModel {
  final ChangeOrderStatusCommandModel changeOrderStatusCommandModel;
  OrderChangeStatusModel({required this.changeOrderStatusCommandModel});
 factory OrderChangeStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderChangeStatusModel(
   changeOrderStatusCommandModel:       ChangeOrderStatusCommandModel.fromJson(json),
          );
        }    
        }
          