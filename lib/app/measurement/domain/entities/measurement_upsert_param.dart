
import 'upsert_measurement_command_param_param.dart';
class MeasurementUpsertParam {
  final UpsertMeasurementCommandParam upsertMeasurementCommandParam;
  MeasurementUpsertParam({required this.upsertMeasurementCommandParam});
 Map<String, dynamic> toJson() {
    return
          upsertMeasurementCommandParam.toJson();
          }    
        }
          