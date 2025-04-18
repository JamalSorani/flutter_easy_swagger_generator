
import 'change_block_status_employee_command_param.dart';
class EmployeeChangeBlockStatusParam {
  final ChangeBlockStatusEmployeeCommand changeBlockStatusEmployeeCommand;
  EmployeeChangeBlockStatusParam({required this.changeBlockStatusEmployeeCommand});
 Map<String, dynamic> toJson() {
    return
          changeBlockStatusEmployeeCommand.toJson();
          }    
        }
          