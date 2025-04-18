
import 'add_employee_command_model_model.dart';
class EmployeeAddModel {
  final AddEmployeeCommandModel addEmployeeCommandModel;
  EmployeeAddModel({required this.addEmployeeCommandModel});
 factory EmployeeAddModel.fromJson(Map<String, dynamic> json) {
    return EmployeeAddModel(
   addEmployeeCommandModel:       AddEmployeeCommandModel.fromJson(json),
          );
        }    
        }
          