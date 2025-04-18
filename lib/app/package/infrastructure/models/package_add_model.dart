
import 'currency_model_model.dart';
import 'product_req_model_model.dart';
class PackageAddModel {
  final String name;
  final CurrencyModel currency;
  final double price;
  final String description;
  final List<String> files;
  final List<ProductReqModel> productReqs;
  PackageAddModel({required this.name, required this.currency, required this.price, required this.description, required this.files, required this.productReqs});
  factory PackageAddModel.fromJson(Map<String, dynamic> json) {
    return PackageAddModel(

      'Name': name,
      'Currency': currency,
      'Price': price,
      'Description': description,
      'Files': files,
      'ProductReqs': productReqs,
    };
  }

}
