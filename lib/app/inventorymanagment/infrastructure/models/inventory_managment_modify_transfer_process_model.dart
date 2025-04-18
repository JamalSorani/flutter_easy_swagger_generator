
import 'product_dto_model_model.dart';
class InventoryManagmentModifyTransferProcessModel {
  final String id;
  final String employeeId;
  final List<ProductDtoModel> productDtos;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final String dateCreated;
  InventoryManagmentModifyTransferProcessModel({required this.id, required this.employeeId, required this.productDtos, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.dateCreated});
  factory InventoryManagmentModifyTransferProcessModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentModifyTransferProcessModel(

      id: json["Id"] ,
      employeeId: json["EmployeeId"] ,
      productDtos: json["ProductDtos"] ,
      modifyImagesFiles: json["ModifyImages.Files"] ,
      modifyImagesDeletedImageUrls: json["ModifyImages.DeletedImageUrls"] ,
      dateCreated: json["DateCreated"] ,
    );
  }

}
