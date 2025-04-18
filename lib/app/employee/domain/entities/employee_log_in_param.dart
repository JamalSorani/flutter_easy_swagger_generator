
import 'log_in_employee_command_param.dart';
class EmployeeLogInParam {
  final LogInEmployeeCommand logInEmployeeCommand;
  EmployeeLogInParam({required this.logInEmployeeCommand});
 Map<String, dynamic> toJson() {
    return
          logInEmployeeCommand.toJson();
          }    
        }
          