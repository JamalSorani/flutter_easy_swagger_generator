class GetInvoicePdfQueryModel {
  final String orderid;

  GetInvoicePdfQueryModel({
    required this.orderid,
  });
  Map<String, dynamic> toJson() {
    return {

      'orderId': orderid,
    };
  }

}
