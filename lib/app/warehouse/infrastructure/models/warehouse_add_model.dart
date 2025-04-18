
import 'add_warehouse_command_model_model.dart';
class WarehouseAddModel {
  final AddWarehouseCommandModel addWarehouseCommandModel;
  WarehouseAddModel({required this.addWarehouseCommandModel});
 factory WarehouseAddModel.fromJson(Map<String, dynamic> json) {
    return WarehouseAddModel(
   addWarehouseCommandModel:       addWarehouseCommandModel.fromJson(json),
          );
        }    
        }
          