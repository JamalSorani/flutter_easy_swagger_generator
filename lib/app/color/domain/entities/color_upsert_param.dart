
import 'upsert_color_command_param_param.dart';
class ColorUpsertParam {
  final UpsertColorCommandParam upsertColorCommandParam;
  ColorUpsertParam({required this.upsertColorCommandParam});
 Map<String, dynamic> toJson() {
    return
          upsertColorCommandParam.toJson();
          }    
        }
          