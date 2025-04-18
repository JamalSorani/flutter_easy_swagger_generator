
import 'upsert_role_command_model_model.dart';
class RoleUpsertRoleModel {
  final UpsertRoleCommandModel upsertRoleCommandModel;
  RoleUpsertRoleModel({required this.upsertRoleCommandModel});
 factory RoleUpsertRoleModel.fromJson(Map<String, dynamic> json) {
    return RoleUpsertRoleModel(
   upsertRoleCommandModel:       upsertRoleCommandModel.fromJson(json),
          );
        }    
        }
          