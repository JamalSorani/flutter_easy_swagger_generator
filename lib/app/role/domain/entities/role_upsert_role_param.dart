
import 'upsert_role_command.dart';
class RoleUpsertRoleParam {
  final UpsertRoleCommand upsertRoleCommand;
  RoleUpsertRoleParam({required this.upsertRoleCommand});
 Map<String, dynamic> toJson() {
    return
          upsertRoleCommand.toJson();
          }    
        }
          