
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

      id: json["Id"] ,
      employeeId: json["EmployeeId"] ,
      warehouseIdOrSalesWindowId: json["WarehouseIdOrSalesWindowId"] ,
      storageLocation: json["StorageLocation"] ,
      modifyImagesFiles: json["ModifyImages.Files"] ,
      modifyImagesDeletedImageUrls: json["ModifyImages.DeletedImageUrls"] ,
      productDtos: json["ProductDtos"] ,
      number: json["Number"] ,
    );
  }

}
