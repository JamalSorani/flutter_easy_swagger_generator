
import 'upsert_fill_style_command_param_param.dart';
class FillStyleUpsertParam {
  final UpsertFillStyleCommandParam upsertFillStyleCommandParam;
  FillStyleUpsertParam({required this.upsertFillStyleCommandParam});
 Map<String, dynamic> toJson() {
    return
          upsertFillStyleCommandParam.toJson();
          }    
        }
          