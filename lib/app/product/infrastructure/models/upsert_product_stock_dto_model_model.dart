class UpsertProductStockDtoModel {
  final double weight;
  final double size;
  final int quantity;
  final String quantitystyleId;
  final String fillstyleAndQuantity;
  final String warehouseidOrSaleswindowId;
  final String storagelocation;

  UpsertProductStockDtoModel({
    required this.weight,
    required this.size,
    required this.quantity,
    required this.quantitystyleId,
    required this.fillstyleAndQuantity,
    required this.warehouseidOrSaleswindowId,
    required this.storagelocation,
  });
  factory UpsertProductStockDtoModel.fromJson(Map<String,dynamic>json){
  return UpsertProductStockDtoModel(

      weight : json["weight"],
      size : json["size"],
      quantity : json["quantity"],
      quantitystyleId : json["quantityStyleId"],
      fillstyleAndQuantity : json["fillStyleAndQuantity"],
      warehouseidOrSaleswindowId : json["warehouseIdOrSaleswindowId"],
      storagelocation : json["storageLocation"],
    );
  }

}
