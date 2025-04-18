
import 'storage_locations_param.dart';
import 'product_dto_param.dart';
class InventoryManagmentModifyInboundOrOutboundProcessParam {
  final String id;
  final String employeeId;
  final String warehouseIdOrSalesWindowId;
  final StorageLocations storageLocation;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final List<ProductDto> productDtos;
  final int number;
  InventoryManagmentModifyInboundOrOutboundProcessParam({required this.id, required this.employeeId, required this.warehouseIdOrSalesWindowId, required this.storageLocation, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.productDtos, required this.number});
}
