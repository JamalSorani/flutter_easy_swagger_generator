class ProductDtoParam {
  final String productid;
  final String currentwarehouseIdOrSalesWindowId;
  final String currentstorageLocation;
  final String newwarehouseIdOrSalesWindowId;
  final String newstorageLocation;
  final int transferquantity;
  final String quantitystyleId;

  ProductDtoParam({
    required this.productid,
    required this.currentwarehouseIdOrSalesWindowId,
    required this.currentstorageLocation,
    required this.newwarehouseIdOrSalesWindowId,
    required this.newstorageLocation,
    required this.transferquantity,
    required this.quantitystyleId,
  });
  Map<String, dynamic> toJson() {
    return {

      'productId': productid,
      'currentWarehouseIdOrSalesWindowId': currentwarehouseIdOrSalesWindowId,
      'currentStorageLocation': currentstorageLocation,
      'newWarehouseIdOrSalesWindowId': newwarehouseIdOrSalesWindowId,
      'newStorageLocation': newstorageLocation,
      'transferQuantity': transferquantity,
      'quantityStyleId': quantitystyleId,
    };
  }

}
