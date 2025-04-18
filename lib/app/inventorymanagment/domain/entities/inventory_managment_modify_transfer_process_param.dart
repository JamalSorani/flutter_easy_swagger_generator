
import 'product_dto_param.dart';
class InventoryManagmentModifyTransferProcessParam {
  final String id;
  final String employeeId;
  final List<ProductDto> productDtos;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final String dateCreated;
  InventoryManagmentModifyTransferProcessParam({required this.id, required this.employeeId, required this.productDtos, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.dateCreated});
}
