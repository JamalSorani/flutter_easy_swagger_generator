
import 'confirm_forget_password_command_model_model.dart';
class EmployeeConfirmForgetPasswordModel {
  final ConfirmForgetPasswordCommandModel confirmForgetPasswordCommandModel;
  EmployeeConfirmForgetPasswordModel({required this.confirmForgetPasswordCommandModel});
 factory EmployeeConfirmForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    return EmployeeConfirmForgetPasswordModel(
   confirmForgetPasswordCommandModel:       ConfirmForgetPasswordCommandModel.fromJson(json),
          );
        }    
        }
          