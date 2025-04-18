
import 'product_dto_param.dart';
class InventoryManagmentAddtransferProcessParam {
  final String employeeId;
  final List<ProductDto> productDtos;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  InventoryManagmentAddtransferProcessParam({required this.employeeId, required this.productDtos, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls});
}
