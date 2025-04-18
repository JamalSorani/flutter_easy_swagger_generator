
import 'modify_customer_command_param.dart';
class CustomerModifyParam {
  final ModifyCustomerCommand modifyCustomerCommand;
  CustomerModifyParam({required this.modifyCustomerCommand});
 Map<String, dynamic> toJson() {
    return
          modifyCustomerCommand.toJson();
          }    
        }
          