
import 'storage_locations_model_model.dart';
import 'product_dto_model_model.dart';
class InventoryManagmentModifyInboundOrOutboundProcessModel {
  final String id;
  final String employeeId;
  final String warehouseIdOrSalesWindowId;
  final StorageLocationsModel storageLocation;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final List<ProductDtoModel> productDtos;
  final int number;
  InventoryManagmentModifyInboundOrOutboundProcessModel({required this.id, required this.employeeId, required this.warehouseIdOrSalesWindowId, required this.storageLocation, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.productDtos, required this.number});
  factory InventoryManagmentModifyInboundOrOutboundProcessModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentModifyInboundOrOutboundProcessModel(

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
