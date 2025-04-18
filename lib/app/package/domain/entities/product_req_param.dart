class ProductReq {
  final String productid;
  final int quantity;

  ProductReq({
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
