import 'order_status_param.dart';
import 'order_product_dto_param.dart';
import 'order_package_dto_param.dart';

class OrderAddParam {
  final String employeeId;
  final OrderStatus status;
  final String customerId;
  final String customerPhoneNumber;
  final String note;
  final double discount;
  final List<String> files;
  final List<OrderProductDto> products;
  final List<OrderPackageDto> packages;
  OrderAddParam(
      {required this.employeeId,
      required this.status,
      required this.customerId,
      required this.customerPhoneNumber,
      required this.note,
      required this.discount,
      required this.files,
      required this.products,
      required this.packages});
}
