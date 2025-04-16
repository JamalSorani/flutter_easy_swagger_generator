
import 'add_warehouse_command.dart';
class WarehouseAddParam {
  final AddWarehouseCommand addWarehouseCommand;
  WarehouseAddParam({required this.addWarehouseCommand});
 Map<String, dynamic> toJson() {
    return
          addWarehouseCommand.toJson();
          }    
        }
          