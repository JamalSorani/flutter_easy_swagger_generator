
import 'modify_my_password_command_param_param.dart';
class EmployeeModifyMyPasswordParam {
  final ModifyMyPasswordCommandParam modifyMyPasswordCommandParam;
  EmployeeModifyMyPasswordParam({required this.modifyMyPasswordCommandParam});
 Map<String, dynamic> toJson() {
    return
          modifyMyPasswordCommandParam.toJson();
          }    
        }
          