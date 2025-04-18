
import 'upsert_fill_style_command_model_model.dart';
class FillStyleUpsertModel {
  final UpsertFillStyleCommandModel upsertFillStyleCommandModel;
  FillStyleUpsertModel({required this.upsertFillStyleCommandModel});
 factory FillStyleUpsertModel.fromJson(Map<String, dynamic> json) {
    return FillStyleUpsertModel(
   upsertFillStyleCommandModel:       UpsertFillStyleCommandModel.fromJson(json),
          );
        }    
        }
          