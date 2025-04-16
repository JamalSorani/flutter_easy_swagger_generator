
import 'add_customer_command.dart';
class CustomerAddParam {
  final AddCustomerCommand addCustomerCommand;
  CustomerAddParam({required this.addCustomerCommand});
 Map<String, dynamic> toJson() {
    return
          addCustomerCommand.toJson();
          }    
        }
          