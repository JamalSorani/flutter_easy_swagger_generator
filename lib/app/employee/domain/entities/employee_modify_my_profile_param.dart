
import 'modify_my_profile_command_param_param.dart';
class EmployeeModifyMyProfileParam {
  final ModifyMyProfileCommandParam modifyMyProfileCommandParam;
  EmployeeModifyMyProfileParam({required this.modifyMyProfileCommandParam});
 Map<String, dynamic> toJson() {
    return
          modifyMyProfileCommandParam.toJson();
          }    
        }
          