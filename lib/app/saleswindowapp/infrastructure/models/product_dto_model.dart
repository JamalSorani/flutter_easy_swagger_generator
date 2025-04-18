class ProductDto {
  final String id;
  final String type;
  final String productid;
  final int quantity;
  final double price;
  final String warehouseorSalesWindowId;
  final String storagelocation;
  final String currency;

  ProductDto({
    required this.id,
    required this.type,
    required this.productid,
    required this.quantity,
    required this.price,
    required this.warehouseorSalesWindowId,
    required this.storagelocation,
    required this.currency,
  });
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'type': type,
      'productId': productid,
      'quantity': quantity,
      'price': price,
      'warehouseOrSalesWindowId': warehouseorSalesWindowId,
      'storageLocation': storagelocation,
      'currency': currency,
    };
  }

}
