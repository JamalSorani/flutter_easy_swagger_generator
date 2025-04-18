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
  factory OrderProductDto.fromJson(Map<String,dynamic>json){
  return OrderProductDto(

      id : json["id"],
      type : json["type"],
      packageid : json["packageId"],
      productid : json["productId"],
      warehouseorSalesWindowId : json["warehouseOrSalesWindowId"],
      storagelocation : json["storageLocation"],
      currency : json["currency"],
      quantity : json["quantity"],
      price : json["price"],
    );
  }

}
