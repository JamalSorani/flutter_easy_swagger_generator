
class ProductGetAllNamesParam {
  final String search;
  final String warehouseOrSalesWindowId;
  final String storageLocation;
  final double quantity;
  ProductGetAllNamesParam({required this.search, required this.warehouseOrSalesWindowId, required this.storageLocation, required this.quantity});
  Map<String, dynamic> toJson() {
    return {

      'Search': search,
      'WarehouseOrSalesWindowId': warehouseOrSalesWindowId,
      'StorageLocation': storageLocation,
      'Quantity': quantity,
    };
  }

}
