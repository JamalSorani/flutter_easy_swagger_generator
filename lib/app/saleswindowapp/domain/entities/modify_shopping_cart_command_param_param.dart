import 'product_dto_param.dart';
import 'package_dto_param.dart';
class ModifyShoppingCartCommandParam {
  final String shoppingcartId;
  final String name;
  final List<ProductDto> productdtos;
  final List<PackageDto> packagedto;

  ModifyShoppingCartCommandParam({
    required this.shoppingcartId,
    required this.name,
    required this.productdtos,
    required this.packagedto,
  });
  Map<String, dynamic> toJson() {
    return {

      'shoppingCartId': shoppingcartId,
      'name': name,
      'productDtos': productdtos,
      'packageDto': packagedto,
    };
  }

}
