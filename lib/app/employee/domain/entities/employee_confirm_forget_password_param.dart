
import 'confirm_forget_password_command_param.dart';
class EmployeeConfirmForgetPasswordParam {
  final ConfirmForgetPasswordCommand confirmForgetPasswordCommand;
  EmployeeConfirmForgetPasswordParam({required this.confirmForgetPasswordCommand});
 Map<String, dynamic> toJson() {
    return
          confirmForgetPasswordCommand.toJson();
          }    
        }
          