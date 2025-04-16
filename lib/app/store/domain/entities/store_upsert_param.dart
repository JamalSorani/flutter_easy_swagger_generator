
import 'upsert_store_command.dart';
class StoreUpsertParam {
  final UpsertStoreCommand upsertStoreCommand;
  StoreUpsertParam({required this.upsertStoreCommand});
 Map<String, dynamic> toJson() {
    return
          upsertStoreCommand.toJson();
          }    
        }
          