
import 'modify_employee_command_param.dart';
class EmployeeModifyParam {
  final ModifyEmployeeCommand modifyEmployeeCommand;
  EmployeeModifyParam({required this.modifyEmployeeCommand});
 Map<String, dynamic> toJson() {
    return
          modifyEmployeeCommand.toJson();
          }    
        }
          