
import 'modify_employee_command_param_param.dart';
class EmployeeModifyParam {
  final ModifyEmployeeCommandParam modifyEmployeeCommandParam;
  EmployeeModifyParam({required this.modifyEmployeeCommandParam});
 Map<String, dynamic> toJson() {
    return
          modifyEmployeeCommandParam.toJson();
          }    
        }
          