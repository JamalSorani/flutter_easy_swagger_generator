
import 'currency_param.dart';
import 'product_req_param.dart';
import 'activation_options_param.dart';
class PackageModifyParam {
  final String id;
  final String name;
  final Currency currency;
  final double price;
  final String description;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final List<ProductReq> productReqs;
  final ActivationOptions status;
  PackageModifyParam({required this.id, required this.name, required this.currency, required this.price, required this.description, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.productReqs, required this.status});
}
