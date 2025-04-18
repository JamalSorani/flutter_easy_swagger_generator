
import 'confirm_forget_password_command_param_param.dart';
class EmployeeConfirmForgetPasswordParam {
  final ConfirmForgetPasswordCommandParam confirmForgetPasswordCommandParam;
  EmployeeConfirmForgetPasswordParam({required this.confirmForgetPasswordCommandParam});
 Map<String, dynamic> toJson() {
    return
          confirmForgetPasswordCommandParam.toJson();
          }    
        }
          