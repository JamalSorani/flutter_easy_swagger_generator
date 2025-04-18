class ProductReqModel {
  final String productid;
  final int quantity;

  ProductReqModel({
    required this.productid,
    required this.quantity,
  });
  factory ProductReqModel.fromJson(Map<String,dynamic>json){
  return ProductReqModel(

      productid : json["productId"],
      quantity : json["quantity"],
    );
  }

}
