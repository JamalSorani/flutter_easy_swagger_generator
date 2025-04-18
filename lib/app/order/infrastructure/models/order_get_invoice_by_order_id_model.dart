
class OrderGetInvoiceByOrderIdModel {
  final String orderId;
  OrderGetInvoiceByOrderIdModel({required this.orderId});
  factory OrderGetInvoiceByOrderIdModel.fromJson(Map<String, dynamic> json) {
    return OrderGetInvoiceByOrderIdModel(

      'OrderId': orderId,
    };
  }

}
