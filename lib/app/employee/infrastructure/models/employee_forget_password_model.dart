
import 'forget_password_command_model_model.dart';
class EmployeeForgetPasswordModel {
  final ForgetPasswordCommandModel forgetPasswordCommandModel;
  EmployeeForgetPasswordModel({required this.forgetPasswordCommandModel});
 factory EmployeeForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return EmployeeForgetPasswordModel(
   forgetPasswordCommandModel:       forgetPasswordCommandModel.fromJson(json),
          );
        }    
        }
          