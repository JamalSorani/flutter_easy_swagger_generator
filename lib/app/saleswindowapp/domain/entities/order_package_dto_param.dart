import 'order_product_dto_param.dart';
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
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'type': type,
      'packageId': packageid,
      'products': products,
    };
  }

}
