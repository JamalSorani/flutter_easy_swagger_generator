
import 'modify_my_password_command_model_model.dart';
class EmployeeModifyMyPasswordModel {
  final ModifyMyPasswordCommandModel modifyMyPasswordCommandModel;
  EmployeeModifyMyPasswordModel({required this.modifyMyPasswordCommandModel});
 factory EmployeeModifyMyPasswordModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModifyMyPasswordModel(
   modifyMyPasswordCommandModel:       modifyMyPasswordCommandModel.fromJson(json),
          );
        }    
        }
          