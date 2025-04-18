
import 'add_customer_command_model_model.dart';
class CustomerAddModel {
  final AddCustomerCommandModel addCustomerCommandModel;
  CustomerAddModel({required this.addCustomerCommandModel});
 factory CustomerAddModel.fromJson(Map<String, dynamic> json) {
    return CustomerAddModel(
   addCustomerCommandModel:       AddCustomerCommandModel.fromJson(json),
          );
        }    
        }
          