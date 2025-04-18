
import 'log_in_employee_command_model_model.dart';
class EmployeeLogInModel {
  final LogInEmployeeCommandModel logInEmployeeCommandModel;
  EmployeeLogInModel({required this.logInEmployeeCommandModel});
 factory EmployeeLogInModel.fromJson(Map<String, dynamic> json) {
    return EmployeeLogInModel(
   logInEmployeeCommandModel:       logInEmployeeCommandModel.fromJson(json),
          );
        }    
        }
          