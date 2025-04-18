
import 'forget_password_command_param_param.dart';
class EmployeeForgetPasswordParam {
  final ForgetPasswordCommandParam forgetPasswordCommandParam;
  EmployeeForgetPasswordParam({required this.forgetPasswordCommandParam});
 Map<String, dynamic> toJson() {
    return
          forgetPasswordCommandParam.toJson();
          }    
        }
          