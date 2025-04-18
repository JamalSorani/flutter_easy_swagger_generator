
import 'upsert_source_command_model_model.dart';
class SourceUpsertModel {
  final UpsertSourceCommandModel upsertSourceCommandModel;
  SourceUpsertModel({required this.upsertSourceCommandModel});
 factory SourceUpsertModel.fromJson(Map<String, dynamic> json) {
    return SourceUpsertModel(
   upsertSourceCommandModel:       upsertSourceCommandModel.fromJson(json),
          );
        }    
        }
          