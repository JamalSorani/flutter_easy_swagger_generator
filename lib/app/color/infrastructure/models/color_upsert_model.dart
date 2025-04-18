
import 'upsert_color_command_model_model.dart';
class ColorUpsertModel {
  final UpsertColorCommandModel upsertColorCommandModel;
  ColorUpsertModel({required this.upsertColorCommandModel});
 factory ColorUpsertModel.fromJson(Map<String, dynamic> json) {
    return ColorUpsertModel(
   upsertColorCommandModel:       UpsertColorCommandModel.fromJson(json),
          );
        }    
        }
          