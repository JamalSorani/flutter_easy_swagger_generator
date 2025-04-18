
import 'add_employee_command_param.dart';
class EmployeeAddParam {
  final AddEmployeeCommand addEmployeeCommand;
  EmployeeAddParam({required this.addEmployeeCommand});
 Map<String, dynamic> toJson() {
    return
          addEmployeeCommand.toJson();
          }    
        }
          