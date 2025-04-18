
import 'order_status_model_model.dart';
import 'order_product_dto_model.dart';
import 'order_package_dto_model.dart';
class SalesWindowAppOrderModifyModel {
  final String orderId;
  final String employeeId;
  final OrderStatusModel status;
  final String customerId;
  final String customerPhoneNumber;
  final String note;
  final double discount;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final List<OrderProductDto> products;
  final List<OrderPackageDto> packages;
  final String reasonForCancellation;
  SalesWindowAppOrderModifyModel({required this.orderId, required this.employeeId, required this.status, required this.customerId, required this.customerPhoneNumber, required this.note, required this.discount, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.products, required this.packages, required this.reasonForCancellation});
  factory SalesWindowAppOrderModifyModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppOrderModifyModel(

      orderId: json["OrderId"] ,
      employeeId: json["EmployeeId"] ,
      status: json["Status"] ,
      customerId: json["CustomerId"] ,
      customerPhoneNumber: json["CustomerPhoneNumber"] ,
      note: json["Note"] ,
      discount: json["Discount"] ,
      modifyImagesFiles: json["ModifyImages.Files"] ,
      modifyImagesDeletedImageUrls: json["ModifyImages.DeletedImageUrls"] ,
      products: json["Products"] ,
      packages: json["Packages"] ,
      reasonForCancellation: json["ReasonForCancellation"] ,
    );
  }

}
