
import 'upsert_store_command_model_model.dart';
class StoreUpsertModel {
  final UpsertStoreCommandModel upsertStoreCommandModel;
  StoreUpsertModel({required this.upsertStoreCommandModel});
 factory StoreUpsertModel.fromJson(Map<String, dynamic> json) {
    return StoreUpsertModel(
   upsertStoreCommandModel:       UpsertStoreCommandModel.fromJson(json),
          );
        }    
        }
          