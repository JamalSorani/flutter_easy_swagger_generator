
import 'modify_my_password_command_param.dart';
class EmployeeModifyMyPasswordParam {
  final ModifyMyPasswordCommand modifyMyPasswordCommand;
  EmployeeModifyMyPasswordParam({required this.modifyMyPasswordCommand});
 Map<String, dynamic> toJson() {
    return
          modifyMyPasswordCommand.toJson();
          }    
        }
          