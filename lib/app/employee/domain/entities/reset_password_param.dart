
import 'reset_password_command_param.dart';
class EmployeeResetPasswordParam {
  final ResetPasswordCommand resetPasswordCommand;
  EmployeeResetPasswordParam({required this.resetPasswordCommand});
 Map<String, dynamic> toJson() {
    return
          resetPasswordCommand.toJson();
          }    
        }
          