
import 'add_employee_command_param_param.dart';
class EmployeeAddParam {
  final AddEmployeeCommandParam addEmployeeCommandParam;
  EmployeeAddParam({required this.addEmployeeCommandParam});
 Map<String, dynamic> toJson() {
    return
          addEmployeeCommandParam.toJson();
          }    
        }
          