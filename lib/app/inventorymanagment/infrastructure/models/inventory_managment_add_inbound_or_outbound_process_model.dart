
import 'inventory_management_type_model_model.dart';
import 'storage_locations_model_model.dart';
import 'product_dto_model_model.dart';
class InventoryManagmentAddInboundOrOutboundProcessModel {
  final InventoryManagementTypeModel inventoryManagementType;
  final String employeeId;
  final String warehouseIdOrSalesWindowId;
  final StorageLocationsModel storageLocation;
  final List<String> files;
  final List<ProductDtoModel> productDtos;
  InventoryManagmentAddInboundOrOutboundProcessModel({required this.inventoryManagementType, required this.employeeId, required this.warehouseIdOrSalesWindowId, required this.storageLocation, required this.files, required this.productDtos});
  factory InventoryManagmentAddInboundOrOutboundProcessModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentAddInboundOrOutboundProcessModel(

      'InventoryManagementType': inventoryManagementType,
      'EmployeeId': employeeId,
      'WarehouseIdOrSalesWindowId': warehouseIdOrSalesWindowId,
      'StorageLocation': storageLocation,
      'Files': files,
      'ProductDtos': productDtos,
    };
  }

}
