
import 'upsert_manufacturer_command_param.dart';
class ManufacturerUpsertParam {
  final UpsertManufacturerCommand upsertManufacturerCommand;
  ManufacturerUpsertParam({required this.upsertManufacturerCommand});
 Map<String, dynamic> toJson() {
    return
          upsertManufacturerCommand.toJson();
          }    
        }
          