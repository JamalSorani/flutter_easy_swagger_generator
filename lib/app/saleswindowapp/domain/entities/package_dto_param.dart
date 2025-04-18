import 'product_dto_param.dart';
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
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'packageId': packageid,
      'type': type,
      'productDtos': productdtos,
    };
  }

}
