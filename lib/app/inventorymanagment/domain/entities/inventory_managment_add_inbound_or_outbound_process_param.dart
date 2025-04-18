
import 'inventory_management_type_param.dart';
import 'storage_locations_param.dart';
import 'product_dto_param.dart';
class InventoryManagmentAddInboundOrOutboundProcessParam {
  final InventoryManagementType inventoryManagementType;
  final String employeeId;
  final String warehouseIdOrSalesWindowId;
  final StorageLocations storageLocation;
  final List<String> files;
  final List<ProductDto> productDtos;
  InventoryManagmentAddInboundOrOutboundProcessParam({required this.inventoryManagementType, required this.employeeId, required this.warehouseIdOrSalesWindowId, required this.storageLocation, required this.files, required this.productDtos});
}
