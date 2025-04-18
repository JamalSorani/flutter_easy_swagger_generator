
import 'modify_my_profile_command_model_model.dart';
class EmployeeModifyMyProfileModel {
  final ModifyMyProfileCommandModel modifyMyProfileCommandModel;
  EmployeeModifyMyProfileModel({required this.modifyMyProfileCommandModel});
 factory EmployeeModifyMyProfileModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModifyMyProfileModel(
   modifyMyProfileCommandModel:       ModifyMyProfileCommandModel.fromJson(json),
          );
        }    
        }
          