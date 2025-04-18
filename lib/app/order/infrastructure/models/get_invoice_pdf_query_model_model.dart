class GetInvoicePdfQueryModel {
  final String orderid;

  GetInvoicePdfQueryModel({
    required this.orderid,
  });
  factory GetInvoicePdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetInvoicePdfQueryModel(

      orderid : json["orderId"],
    );
  }

}
