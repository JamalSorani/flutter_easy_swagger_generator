
import 'modify_customer_command_param_param.dart';
class CustomerModifyParam {
  final ModifyCustomerCommandParam modifyCustomerCommandParam;
  CustomerModifyParam({required this.modifyCustomerCommandParam});
 Map<String, dynamic> toJson() {
    return
          modifyCustomerCommandParam.toJson();
          }    
        }
          