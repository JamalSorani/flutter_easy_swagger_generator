import 'product_dto_model.dart';
class PackageDto {
  final String id;
  final String packageid;
  final String type;
  final List<ProductDto> productdtos;

  PackageDto({
    required this.id,
    required this.packageid,
    required this.type,
    required this.productdtos,
  });
  factory PackageDto.fromJson(Map<String,dynamic>json){
  return PackageDto(

      id : json["id"],
      packageid : json["packageId"],
      type : json["type"],
      productdtos : json["productDtos"],
    );
  }

}
