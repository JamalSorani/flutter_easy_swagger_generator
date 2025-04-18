
import 'upsert_store_command_param.dart';
class StoreUpsertParam {
  final UpsertStoreCommand upsertStoreCommand;
  StoreUpsertParam({required this.upsertStoreCommand});
 Map<String, dynamic> toJson() {
    return
          upsertStoreCommand.toJson();
          }    
        }
          