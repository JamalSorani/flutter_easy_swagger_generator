
import 'product_dto_model_model.dart';
class InventoryManagmentAddtransferProcessModel {
  final String employeeId;
  final List<ProductDtoModel> productDtos;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  InventoryManagmentAddtransferProcessModel({required this.employeeId, required this.productDtos, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls});
  factory InventoryManagmentAddtransferProcessModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentAddtransferProcessModel(

      'EmployeeId': employeeId,
      'ProductDtos': productDtos,
      'ModifyImages.Files': modifyImagesFiles,
      'ModifyImages.DeletedImageUrls': modifyImagesDeletedImageUrls,
    };
  }

}
