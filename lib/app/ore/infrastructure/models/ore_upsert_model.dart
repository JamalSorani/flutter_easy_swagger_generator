
import 'upsert_ore_command_model_model.dart';
class OreUpsertModel {
  final UpsertOreCommandModel upsertOreCommandModel;
  OreUpsertModel({required this.upsertOreCommandModel});
 factory OreUpsertModel.fromJson(Map<String, dynamic> json) {
    return OreUpsertModel(
   upsertOreCommandModel:       upsertOreCommandModel.fromJson(json),
          );
        }    
        }
          