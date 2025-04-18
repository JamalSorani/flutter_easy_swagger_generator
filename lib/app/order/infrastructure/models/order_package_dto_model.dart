import 'order_product_dto_model.dart';
class OrderPackageDto {
  final String id;
  final String type;
  final String packageid;
  final List<OrderProductDto> products;

  OrderPackageDto({
    required this.id,
    required this.type,
    required this.packageid,
    required this.products,
  });
  factory OrderPackageDto.fromJson(Map<String,dynamic>json){
  return OrderPackageDto(

      id : json["id"],
      type : json["type"],
      packageid : json["packageId"],
      products : json["products"],
    );
  }

}
