
import 'change_order_status_command_param_param.dart';
class OrderChangeStatusParam {
  final ChangeOrderStatusCommandParam changeOrderStatusCommandParam;
  OrderChangeStatusParam({required this.changeOrderStatusCommandParam});
 Map<String, dynamic> toJson() {
    return
          changeOrderStatusCommandParam.toJson();
          }    
        }
          