
import 'add_customer_command_param.dart';
class CustomerAddParam {
  final AddCustomerCommand addCustomerCommand;
  CustomerAddParam({required this.addCustomerCommand});
 Map<String, dynamic> toJson() {
    return
          addCustomerCommand.toJson();
          }    
        }
          