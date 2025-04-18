
import 'upsert_ore_command_param_param.dart';
class OreUpsertParam {
  final UpsertOreCommandParam upsertOreCommandParam;
  OreUpsertParam({required this.upsertOreCommandParam});
 Map<String, dynamic> toJson() {
    return
          upsertOreCommandParam.toJson();
          }    
        }
          