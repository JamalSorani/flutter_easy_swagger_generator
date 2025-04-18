
import 'change_order_status_command_param.dart';
class OrderChangeStatusParam {
  final ChangeOrderStatusCommand changeOrderStatusCommand;
  OrderChangeStatusParam({required this.changeOrderStatusCommand});
 Map<String, dynamic> toJson() {
    return
          changeOrderStatusCommand.toJson();
          }    
        }
          