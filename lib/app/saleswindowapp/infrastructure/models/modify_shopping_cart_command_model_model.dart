import 'product_dto_model.dart';
import 'package_dto_model.dart';
class ModifyShoppingCartCommandModel {
  final String shoppingcartId;
  final String name;
  final List<ProductDto> productdtos;
  final List<PackageDto> packagedto;

  ModifyShoppingCartCommandModel({
    required this.shoppingcartId,
    required this.name,
    required this.productdtos,
    required this.packagedto,
  });
  factory ModifyShoppingCartCommandModel.fromJson(Map<String,dynamic>json){
  return ModifyShoppingCartCommandModel(

      shoppingcartId : json["shoppingCartId"],
      name : json["name"],
      productdtos : json["productDtos"],
      packagedto : json["packageDto"],
    );
  }

}
