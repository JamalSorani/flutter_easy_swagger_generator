class ProductReqModel {
  final String productid;
  final int quantity;

  ProductReqModel({
    required this.productid,
    required this.quantity,
  });
  Map<String, dynamic> toJson() {
    return {

      'productId': productid,
      'quantity': quantity,
    };
  }

}
