
import 'upsert_measurement_command_model_model.dart';
class MeasurementUpsertModel {
  final UpsertMeasurementCommandModel upsertMeasurementCommandModel;
  MeasurementUpsertModel({required this.upsertMeasurementCommandModel});
 factory MeasurementUpsertModel.fromJson(Map<String, dynamic> json) {
    return MeasurementUpsertModel(
   upsertMeasurementCommandModel:       UpsertMeasurementCommandModel.fromJson(json),
          );
        }    
        }
          