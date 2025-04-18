
import 'reset_password_command_param_param.dart';
class EmployeeResetPasswordParam {
  final ResetPasswordCommandParam resetPasswordCommandParam;
  EmployeeResetPasswordParam({required this.resetPasswordCommandParam});
 Map<String, dynamic> toJson() {
    return
          resetPasswordCommandParam.toJson();
          }    
        }
          