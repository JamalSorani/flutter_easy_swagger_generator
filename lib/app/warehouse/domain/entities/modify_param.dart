
import 'modify_warehouse_command_param.dart';
class WarehouseModifyParam {
  final ModifyWarehouseCommand modifyWarehouseCommand;
  WarehouseModifyParam({required this.modifyWarehouseCommand});
 Map<String, dynamic> toJson() {
    return
          modifyWarehouseCommand.toJson();
          }    
        }
          