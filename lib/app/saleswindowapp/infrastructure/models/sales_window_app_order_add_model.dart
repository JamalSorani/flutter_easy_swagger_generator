
import 'product_dto_model.dart';
import 'package_dto_model.dart';
class SalesWindowAppOrderAddModel {
  final String customerId;
  final String customerPhoneNumber;
  final List<ProductDto> productDtos;
  final List<PackageDto> packageDtos;
  final List<String> files;
  final String note;
  SalesWindowAppOrderAddModel({required this.customerId, required this.customerPhoneNumber, required this.productDtos, required this.packageDtos, required this.files, required this.note});
  factory SalesWindowAppOrderAddModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppOrderAddModel(

      'CustomerId': customerId,
      'CustomerPhoneNumber': customerPhoneNumber,
      'ProductDtos': productDtos,
      'PackageDtos': packageDtos,
      'Files': files,
      'Note': note,
    };
  }

}
