
import 'upsert_measurement_command.dart';
class MeasurementUpsertParam {
  final UpsertMeasurementCommand upsertMeasurementCommand;
  MeasurementUpsertParam({required this.upsertMeasurementCommand});
 Map<String, dynamic> toJson() {
    return
          upsertMeasurementCommand.toJson();
          }    
        }
          