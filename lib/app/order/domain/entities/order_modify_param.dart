
import 'order_status_param_param.dart';
import 'order_product_dto_param.dart';
import 'order_package_dto_param.dart';
class OrderModifyParam {
  final String orderId;
  final String employeeId;
  final OrderStatusParam status;
  final String customerId;
  final String customerPhoneNumber;
  final String note;
  final double discount;
  final List<String> modifyImagesFiles;
  final List<String> modifyImagesDeletedImageUrls;
  final List<OrderProductDto> products;
  final List<OrderPackageDto> packages;
  final String reasonForCancellation;
  OrderModifyParam({required this.orderId, required this.employeeId, required this.status, required this.customerId, required this.customerPhoneNumber, required this.note, required this.discount, required this.modifyImagesFiles, required this.modifyImagesDeletedImageUrls, required this.products, required this.packages, required this.reasonForCancellation});
  Map<String, dynamic> toJson() {
    return {

      'OrderId': orderId,
      'EmployeeId': employeeId,
      'Status': status,
      'CustomerId': customerId,
      'CustomerPhoneNumber': customerPhoneNumber,
      'Note': note,
      'Discount': discount,
      'ModifyImages.Files': modifyImagesFiles,
      'ModifyImages.DeletedImageUrls': modifyImagesDeletedImageUrls,
      'Products': products,
      'Packages': packages,
      'ReasonForCancellation': reasonForCancellation,
    };
  }

}
