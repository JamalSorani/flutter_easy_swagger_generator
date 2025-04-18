
import 'reset_password_command_model_model.dart';
class EmployeeResetPasswordModel {
  final ResetPasswordCommandModel resetPasswordCommandModel;
  EmployeeResetPasswordModel({required this.resetPasswordCommandModel});
 factory EmployeeResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return EmployeeResetPasswordModel(
   resetPasswordCommandModel:       resetPasswordCommandModel.fromJson(json),
          );
        }    
        }
          