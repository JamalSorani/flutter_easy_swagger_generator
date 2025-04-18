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
  factory AddShoppingCartCommandModel.fromJson(Map<String,dynamic>json){
  return AddShoppingCartCommandModel(

      name : json["name"],
      productdtos : json["productDtos"],
      packagedtos : json["packageDtos"],
    );
  }

}
