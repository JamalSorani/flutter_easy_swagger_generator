
import 'add_employee_command.dart';
class EmployeeAddParam {
  final AddEmployeeCommand addEmployeeCommand;
  EmployeeAddParam({required this.addEmployeeCommand});
 Map<String, dynamic> toJson() {
    return
          addEmployeeCommand.toJson();
          }    
        }
          