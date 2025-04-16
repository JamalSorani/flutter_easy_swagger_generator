
import 'change_order_status_command.dart';
class OrderChangeStatusParam {
  final ChangeOrderStatusCommand changeOrderStatusCommand;
  OrderChangeStatusParam({required this.changeOrderStatusCommand});
 Map<String, dynamic> toJson() {
    return
          changeOrderStatusCommand.toJson();
          }    
        }
          