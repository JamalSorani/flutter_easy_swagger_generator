
import 'forget_password_command.dart';
class EmployeeForgetPasswordParam {
  final ForgetPasswordCommand forgetPasswordCommand;
  EmployeeForgetPasswordParam({required this.forgetPasswordCommand});
 Map<String, dynamic> toJson() {
    return
          forgetPasswordCommand.toJson();
          }    
        }
          