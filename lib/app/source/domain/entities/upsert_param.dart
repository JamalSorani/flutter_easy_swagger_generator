
import 'upsert_source_command_param.dart';
class SourceUpsertParam {
  final UpsertSourceCommand upsertSourceCommand;
  SourceUpsertParam({required this.upsertSourceCommand});
 Map<String, dynamic> toJson() {
    return
          upsertSourceCommand.toJson();
          }    
        }
          