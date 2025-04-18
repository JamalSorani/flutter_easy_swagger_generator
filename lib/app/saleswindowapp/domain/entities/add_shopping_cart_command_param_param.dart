import 'product_dto_param.dart';
import 'package_dto_param.dart';
class AddShoppingCartCommandParam {
  final String name;
  final List<ProductDto> productdtos;
  final List<PackageDto> packagedtos;

  AddShoppingCartCommandParam({
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
