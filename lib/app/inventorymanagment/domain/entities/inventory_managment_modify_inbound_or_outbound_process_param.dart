
import 'storage_locations_param_param.dart';
import 'product_dto_param_param.dart';
class InventoryManagmentModifyInboundOrOutboundProcessParam {
  final String id;
  final String employeeId;
  final String warehouseIdOrSalesWindowId;
  final StorageLocationsParam storageLocation;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final List<ProductDtoParam> productDtos;
  final int number;
  InventoryManagmentModifyInboundOrOutboundProcessParam({required this.id, required this.employeeId, required this.warehouseIdOrSalesWindowId, required this.storageLocation, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.productDtos, required this.number});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
      'EmployeeId': employeeId,
      'WarehouseIdOrSalesWindowId': warehouseIdOrSalesWindowId,
      'StorageLocation': storageLocation,
      'ModifyImages.Files': modifyImagesFiles,
      'ModifyImages.DeletedImageUrls': modifyImagesDeletedImageUrls,
      'ProductDtos': productDtos,
      'Number': number,
    };
  }

}
