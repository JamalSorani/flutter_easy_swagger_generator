
import 'inventory_management_type_param_param.dart';
import 'storage_locations_param_param.dart';
import 'product_dto_param_param.dart';
class InventoryManagmentAddInboundOrOutboundProcessParam {
  final InventoryManagementTypeParam inventoryManagementType;
  final String employeeId;
  final String warehouseIdOrSalesWindowId;
  final StorageLocationsParam storageLocation;
  final List<String> files;
  final List<ProductDtoParam> productDtos;
  InventoryManagmentAddInboundOrOutboundProcessParam({required this.inventoryManagementType, required this.employeeId, required this.warehouseIdOrSalesWindowId, required this.storageLocation, required this.files, required this.productDtos});
  Map<String, dynamic> toJson() {
    return {

      'InventoryManagementType': inventoryManagementType,
      'EmployeeId': employeeId,
      'WarehouseIdOrSalesWindowId': warehouseIdOrSalesWindowId,
      'StorageLocation': storageLocation,
      'Files': files,
      'ProductDtos': productDtos,
    };
  }

}
