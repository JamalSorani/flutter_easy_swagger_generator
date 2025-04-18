
import 'add_customer_command_param_param.dart';
class CustomerAddParam {
  final AddCustomerCommandParam addCustomerCommandParam;
  CustomerAddParam({required this.addCustomerCommandParam});
 Map<String, dynamic> toJson() {
    return
          addCustomerCommandParam.toJson();
          }    
        }
          