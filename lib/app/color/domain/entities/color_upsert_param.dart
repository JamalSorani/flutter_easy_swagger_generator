
import 'upsert_color_command.dart';
class ColorUpsertParam {
  final UpsertColorCommand upsertColorCommand;
  ColorUpsertParam({required this.upsertColorCommand});
 Map<String, dynamic> toJson() {
    return
          upsertColorCommand.toJson();
          }    
        }
          