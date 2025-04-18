
import 'currency_model_model.dart';
import 'product_req_model_model.dart';
import 'activation_options_model_model.dart';
class PackageModifyModel {
  final String id;
  final String name;
  final CurrencyModel currency;
  final double price;
  final String description;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final List<ProductReqModel> productReqs;
  final ActivationOptionsModel status;
  PackageModifyModel({required this.id, required this.name, required this.currency, required this.price, required this.description, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.productReqs, required this.status});
  factory PackageModifyModel.fromJson(Map<String, dynamic> json) {
    return PackageModifyModel(

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
