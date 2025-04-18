class OrderProductDto {
  final String id;
  final String type;
  final String packageid;
  final String productid;
  final String warehouseorSalesWindowId;
  final String storagelocation;
  final String currency;
  final int quantity;
  final double price;

  OrderProductDto({
    required this.id,
    required this.type,
    required this.packageid,
    required this.productid,
    required this.warehouseorSalesWindowId,
    required this.storagelocation,
    required this.currency,
    required this.quantity,
    required this.price,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'packageId': packageid,
      'productId': productid,
      'warehouseOrSalesWindowId': warehouseorSalesWindowId,
      'storageLocation': storagelocation,
      'currency': currency,
      'quantity': quantity,
      'price': price,
    };
  }
}
