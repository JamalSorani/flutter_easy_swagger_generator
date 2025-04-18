
import 'change_block_status_employee_command_param_param.dart';
class EmployeeChangeBlockStatusParam {
  final ChangeBlockStatusEmployeeCommandParam changeBlockStatusEmployeeCommandParam;
  EmployeeChangeBlockStatusParam({required this.changeBlockStatusEmployeeCommandParam});
 Map<String, dynamic> toJson() {
    return
          changeBlockStatusEmployeeCommandParam.toJson();
          }    
        }
          