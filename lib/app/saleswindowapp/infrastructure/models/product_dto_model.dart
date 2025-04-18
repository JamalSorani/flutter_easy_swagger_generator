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
  factory ProductDto.fromJson(Map<String,dynamic>json){
  return ProductDto(

      id : json["id"],
      type : json["type"],
      productid : json["productId"],
      quantity : json["quantity"],
      price : json["price"],
      warehouseorSalesWindowId : json["warehouseOrSalesWindowId"],
      storagelocation : json["storageLocation"],
      currency : json["currency"],
    );
  }

}
