
import 'product_dto_param.dart';
import 'package_dto_param.dart';
class SalesWindowAppOrderAddParam {
  final String customerId;
  final String customerPhoneNumber;
  final List<ProductDto> productDtos;
  final List<PackageDto> packageDtos;
  final List<String> files;
  final String note;
  SalesWindowAppOrderAddParam({required this.customerId, required this.customerPhoneNumber, required this.productDtos, required this.packageDtos, required this.files, required this.note});
}
