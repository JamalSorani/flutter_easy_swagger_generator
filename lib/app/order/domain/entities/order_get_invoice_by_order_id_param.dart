
class OrderGetInvoiceByOrderIdParam {
  final String orderId;
  OrderGetInvoiceByOrderIdParam({required this.orderId});
  Map<String, dynamic> toJson() {
    return {

      'OrderId': orderId,
    };
  }

}
