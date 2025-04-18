
import 'upsert_quantity_style_command_model_model.dart';
class QuantityStyleUpsertModel {
  final UpsertQuantityStyleCommandModel upsertQuantityStyleCommandModel;
  QuantityStyleUpsertModel({required this.upsertQuantityStyleCommandModel});
 factory QuantityStyleUpsertModel.fromJson(Map<String, dynamic> json) {
    return QuantityStyleUpsertModel(
   upsertQuantityStyleCommandModel:       UpsertQuantityStyleCommandModel.fromJson(json),
          );
        }    
        }
          