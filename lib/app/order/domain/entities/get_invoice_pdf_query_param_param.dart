class GetInvoicePdfQueryParam {
  final String orderid;

  GetInvoicePdfQueryParam({
    required this.orderid,
  });
  Map<String, dynamic> toJson() {
    return {

      'orderId': orderid,
    };
  }

}
