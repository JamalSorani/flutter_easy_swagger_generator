
import 'log_in_employee_command_param_param.dart';
class EmployeeLogInParam {
  final LogInEmployeeCommandParam logInEmployeeCommandParam;
  EmployeeLogInParam({required this.logInEmployeeCommandParam});
 Map<String, dynamic> toJson() {
    return
          logInEmployeeCommandParam.toJson();
          }    
        }
          