
import 'upsert_source_command_param_param.dart';
class SourceUpsertParam {
  final UpsertSourceCommandParam upsertSourceCommandParam;
  SourceUpsertParam({required this.upsertSourceCommandParam});
 Map<String, dynamic> toJson() {
    return
          upsertSourceCommandParam.toJson();
          }    
        }
          