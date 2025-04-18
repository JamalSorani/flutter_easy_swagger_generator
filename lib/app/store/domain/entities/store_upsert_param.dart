
import 'upsert_store_command_param_param.dart';
class StoreUpsertParam {
  final UpsertStoreCommandParam upsertStoreCommandParam;
  StoreUpsertParam({required this.upsertStoreCommandParam});
 Map<String, dynamic> toJson() {
    return
          upsertStoreCommandParam.toJson();
          }    
        }
          