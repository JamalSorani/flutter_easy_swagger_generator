
import 'upsert_manufacturer_command_param_param.dart';
class ManufacturerUpsertParam {
  final UpsertManufacturerCommandParam upsertManufacturerCommandParam;
  ManufacturerUpsertParam({required this.upsertManufacturerCommandParam});
 Map<String, dynamic> toJson() {
    return
          upsertManufacturerCommandParam.toJson();
          }    
        }
          