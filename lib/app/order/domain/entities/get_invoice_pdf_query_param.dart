class GetInvoicePdfQuery {
  final String orderid;

  GetInvoicePdfQuery({
    required this.orderid,
  });
  Map<String, dynamic> toJson() {
    return {

      'orderId': orderid,
    };
  }

}
