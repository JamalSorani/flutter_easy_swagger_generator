
import 'modify_warehouse_command_model_model.dart';
class WarehouseModifyModel {
  final ModifyWarehouseCommandModel modifyWarehouseCommandModel;
  WarehouseModifyModel({required this.modifyWarehouseCommandModel});
 factory WarehouseModifyModel.fromJson(Map<String, dynamic> json) {
    return WarehouseModifyModel(
   modifyWarehouseCommandModel:       ModifyWarehouseCommandModel.fromJson(json),
          );
        }    
        }
          