
import 'product_dto_param_param.dart';
class InventoryManagmentAddtransferProcessParam {
  final String employeeId;
  final List<ProductDtoParam> productDtos;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  InventoryManagmentAddtransferProcessParam({required this.employeeId, required this.productDtos, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls});
  Map<String, dynamic> toJson() {
    return {

      'EmployeeId': employeeId,
      'ProductDtos': productDtos,
      'ModifyImages.Files': modifyImagesFiles,
      'ModifyImages.DeletedImageUrls': modifyImagesDeletedImageUrls,
    };
  }

}
