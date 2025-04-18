
import 'modify_warehouse_command_param_param.dart';
class WarehouseModifyParam {
  final ModifyWarehouseCommandParam modifyWarehouseCommandParam;
  WarehouseModifyParam({required this.modifyWarehouseCommandParam});
 Map<String, dynamic> toJson() {
    return
          modifyWarehouseCommandParam.toJson();
          }    
        }
          