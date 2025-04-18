
import 'product_dto_model_model.dart';
class InventoryManagmentAddtransferProcessModel {
  final String employeeId;
  final List<ProductDtoModel> productDtos;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  InventoryManagmentAddtransferProcessModel({required this.employeeId, required this.productDtos, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls});
  factory InventoryManagmentAddtransferProcessModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentAddtransferProcessModel(

      employeeId: json["EmployeeId"] ,
      productDtos: json["ProductDtos"] ,
      modifyImagesFiles: json["ModifyImages.Files"] ,
      modifyImagesDeletedImageUrls: json["ModifyImages.DeletedImageUrls"] ,
    );
  }

}
