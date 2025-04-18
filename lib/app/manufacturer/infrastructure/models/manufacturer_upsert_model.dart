
import 'upsert_manufacturer_command_model_model.dart';
class ManufacturerUpsertModel {
  final UpsertManufacturerCommandModel upsertManufacturerCommandModel;
  ManufacturerUpsertModel({required this.upsertManufacturerCommandModel});
 factory ManufacturerUpsertModel.fromJson(Map<String, dynamic> json) {
    return ManufacturerUpsertModel(
   upsertManufacturerCommandModel:       upsertManufacturerCommandModel.fromJson(json),
          );
        }    
        }
          