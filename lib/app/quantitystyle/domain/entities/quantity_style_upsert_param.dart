
import 'upsert_quantity_style_command_param_param.dart';
class QuantityStyleUpsertParam {
  final UpsertQuantityStyleCommandParam upsertQuantityStyleCommandParam;
  QuantityStyleUpsertParam({required this.upsertQuantityStyleCommandParam});
 Map<String, dynamic> toJson() {
    return
          upsertQuantityStyleCommandParam.toJson();
          }    
        }
          