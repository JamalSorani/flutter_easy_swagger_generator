
import 'change_block_status_employee_command_model_model.dart';
class EmployeeChangeBlockStatusModel {
  final ChangeBlockStatusEmployeeCommandModel changeBlockStatusEmployeeCommandModel;
  EmployeeChangeBlockStatusModel({required this.changeBlockStatusEmployeeCommandModel});
 factory EmployeeChangeBlockStatusModel.fromJson(Map<String, dynamic> json) {
    return EmployeeChangeBlockStatusModel(
   changeBlockStatusEmployeeCommandModel:       ChangeBlockStatusEmployeeCommandModel.fromJson(json),
          );
        }    
        }
          