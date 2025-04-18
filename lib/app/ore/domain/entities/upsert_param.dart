
import 'upsert_ore_command_param.dart';
class OreUpsertParam {
  final UpsertOreCommand upsertOreCommand;
  OreUpsertParam({required this.upsertOreCommand});
 Map<String, dynamic> toJson() {
    return
          upsertOreCommand.toJson();
          }    
        }
          