
import 'add_warehouse_command_param_param.dart';
class WarehouseAddParam {
  final AddWarehouseCommandParam addWarehouseCommandParam;
  WarehouseAddParam({required this.addWarehouseCommandParam});
 Map<String, dynamic> toJson() {
    return
          addWarehouseCommandParam.toJson();
          }    
        }
          