
import 'modify_customer_command_model_model.dart';
class CustomerModifyModel {
  final ModifyCustomerCommandModel modifyCustomerCommandModel;
  CustomerModifyModel({required this.modifyCustomerCommandModel});
 factory CustomerModifyModel.fromJson(Map<String, dynamic> json) {
    return CustomerModifyModel(
   modifyCustomerCommandModel:       modifyCustomerCommandModel.fromJson(json),
          );
        }    
        }
          