import 'product_dto_model.dart';
import 'package_dto_model.dart';
class AddShoppingCartCommandModel {
  final String name;
  final List<ProductDto> productdtos;
  final List<PackageDto> packagedtos;

  AddShoppingCartCommandModel({
    required this.name,
    required this.productdtos,
    required this.packagedtos,
  });
  Map<String, dynamic> toJson() {
    return {

      'name': name,
      'productDtos': productdtos,
      'packageDtos': packagedtos,
    };
  }

}
