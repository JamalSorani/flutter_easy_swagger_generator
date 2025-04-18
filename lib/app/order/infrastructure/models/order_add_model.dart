
import 'order_status_model_model.dart';
import 'order_product_dto_model.dart';
import 'order_package_dto_model.dart';
class OrderAddModel {
  final String employeeId;
  final OrderStatusModel status;
  final String customerId;
  final String customerPhoneNumber;
  final String note;
  final double discount;
  final List<String> files;
  final List<OrderProductDto> products;
  final List<OrderPackageDto> packages;
  OrderAddModel({required this.employeeId, required this.status, required this.customerId, required this.customerPhoneNumber, required this.note, required this.discount, required this.files, required this.products, required this.packages});
  factory OrderAddModel.fromJson(Map<String, dynamic> json) {
    return OrderAddModel(

      employeeId: json["EmployeeId"] ,
      status: json["Status"] ,
      customerId: json["CustomerId"] ,
      customerPhoneNumber: json["CustomerPhoneNumber"] ,
      note: json["Note"] ,
      discount: json["Discount"] ,
      files: json["Files"] ,
      products: json["Products"] ,
      packages: json["Packages"] ,
    );
  }

}
