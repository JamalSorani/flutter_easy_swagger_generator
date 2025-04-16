
import 'modify_my_profile_command.dart';
class EmployeeModifyMyProfileParam {
  final ModifyMyProfileCommand modifyMyProfileCommand;
  EmployeeModifyMyProfileParam({required this.modifyMyProfileCommand});
 Map<String, dynamic> toJson() {
    return
          modifyMyProfileCommand.toJson();
          }    
        }
          