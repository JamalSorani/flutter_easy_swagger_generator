class ProductReqParam {
  final String productid;
  final int quantity;

  ProductReqParam({
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
