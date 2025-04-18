
import 'upsert_role_command_param.dart';
class RoleUpsertRoleParam {
  final UpsertRoleCommand upsertRoleCommand;
  RoleUpsertRoleParam({required this.upsertRoleCommand});
 Map<String, dynamic> toJson() {
    return
          upsertRoleCommand.toJson();
          }    
        }
          