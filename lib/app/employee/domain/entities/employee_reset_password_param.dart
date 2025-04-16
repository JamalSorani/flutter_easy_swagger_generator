
import 'reset_password_command.dart';
class EmployeeResetPasswordParam {
  final ResetPasswordCommand resetPasswordCommand;
  EmployeeResetPasswordParam({required this.resetPasswordCommand});
 Map<String, dynamic> toJson() {
    return
          resetPasswordCommand.toJson();
          }    
        }
          