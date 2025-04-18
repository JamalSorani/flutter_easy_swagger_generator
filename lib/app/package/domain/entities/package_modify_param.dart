
import 'currency_param_param.dart';
import 'product_req_param_param.dart';
import 'activation_options_param_param.dart';
class PackageModifyParam {
  final String id;
  final String name;
  final CurrencyParam currency;
  final double price;
  final String description;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final List<ProductReqParam> productReqs;
  final ActivationOptionsParam status;
  PackageModifyParam({required this.id, required this.name, required this.currency, required this.price, required this.description, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.productReqs, required this.status});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
      'Name': name,
      'Currency': currency,
      'Price': price,
      'Description': description,
      'ModifyImages.Files': modifyImagesFiles,
      'ModifyImages.DeletedImageUrls': modifyImagesDeletedImageUrls,
      'ProductReqs': productReqs,
      'Status': status,
    };
  }

}
