
import 'currency_param_param.dart';
import 'product_req_param_param.dart';
class PackageAddParam {
  final String name;
  final CurrencyParam currency;
  final double price;
  final String description;
  final List<String> files;
  final List<ProductReqParam> productReqs;
  PackageAddParam({required this.name, required this.currency, required this.price, required this.description, required this.files, required this.productReqs});
  Map<String, dynamic> toJson() {
    return {

      'Name': name,
      'Currency': currency,
      'Price': price,
      'Description': description,
      'Files': files,
      'ProductReqs': productReqs,
    };
  }

}
