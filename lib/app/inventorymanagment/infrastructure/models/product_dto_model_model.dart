class ProductDtoModel {
  final String productid;
  final String currentwarehouseIdOrSalesWindowId;
  final String currentstorageLocation;
  final String newwarehouseIdOrSalesWindowId;
  final String newstorageLocation;
  final int transferquantity;
  final String quantitystyleId;

  ProductDtoModel({
    required this.productid,
    required this.currentwarehouseIdOrSalesWindowId,
    required this.currentstorageLocation,
    required this.newwarehouseIdOrSalesWindowId,
    required this.newstorageLocation,
    required this.transferquantity,
    required this.quantitystyleId,
  });
  factory ProductDtoModel.fromJson(Map<String,dynamic>json){
  return ProductDtoModel(

      productid : json["productId"],
      currentwarehouseIdOrSalesWindowId : json["currentWarehouseIdOrSalesWindowId"],
      currentstorageLocation : json["currentStorageLocation"],
      newwarehouseIdOrSalesWindowId : json["newWarehouseIdOrSalesWindowId"],
      newstorageLocation : json["newStorageLocation"],
      transferquantity : json["transferQuantity"],
      quantitystyleId : json["quantityStyleId"],
    );
  }

}
