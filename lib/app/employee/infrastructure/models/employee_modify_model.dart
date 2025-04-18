
import 'modify_employee_command_model_model.dart';
class EmployeeModifyModel {
  final ModifyEmployeeCommandModel modifyEmployeeCommandModel;
  EmployeeModifyModel({required this.modifyEmployeeCommandModel});
 factory EmployeeModifyModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModifyModel(
   modifyEmployeeCommandModel:       ModifyEmployeeCommandModel.fromJson(json),
          );
        }    
        }
          