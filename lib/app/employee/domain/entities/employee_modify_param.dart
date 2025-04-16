
import 'modify_employee_command.dart';
class EmployeeModifyParam {
  final ModifyEmployeeCommand modifyEmployeeCommand;
  EmployeeModifyParam({required this.modifyEmployeeCommand});
 Map<String, dynamic> toJson() {
    return
          modifyEmployeeCommand.toJson();
          }    
        }
          