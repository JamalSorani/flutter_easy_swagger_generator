import '../../../currencyexchange/domain/entities/currency_param.dart';
import 'product_req_param.dart';

class PackageAddParam {
  final String name;
  final Currency currency;
  final double price;
  final String description;
  final List<String> files;
  final List<ProductReq> productReqs;
  PackageAddParam(
      {required this.name,
      required this.currency,
      required this.price,
      required this.description,
      required this.files,
      required this.productReqs});
}
