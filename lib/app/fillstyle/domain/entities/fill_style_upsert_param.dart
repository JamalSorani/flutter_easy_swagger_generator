
import 'upsert_fill_style_command_param.dart';
class FillStyleUpsertParam {
  final UpsertFillStyleCommand upsertFillStyleCommand;
  FillStyleUpsertParam({required this.upsertFillStyleCommand});
 Map<String, dynamic> toJson() {
    return
          upsertFillStyleCommand.toJson();
          }    
        }
          