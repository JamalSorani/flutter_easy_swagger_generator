
import 'upsert_quantity_style_command.dart';
class QuantityStyleUpsertParam {
  final UpsertQuantityStyleCommand upsertQuantityStyleCommand;
  QuantityStyleUpsertParam({required this.upsertQuantityStyleCommand});
 Map<String, dynamic> toJson() {
    return
          upsertQuantityStyleCommand.toJson();
          }    
        }
          