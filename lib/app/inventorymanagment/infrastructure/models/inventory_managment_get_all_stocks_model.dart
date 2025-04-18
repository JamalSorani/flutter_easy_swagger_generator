
class InventoryManagmentGetAllStocksModel {
  final String search;
  final String warehouseOrSalesWindowId;
  final String storageLocation;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  InventoryManagmentGetAllStocksModel({required this.search, required this.warehouseOrSalesWindowId, required this.storageLocation, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory InventoryManagmentGetAllStocksModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentGetAllStocksModel(

      'Search': search,
      'WarehouseOrSalesWindowId': warehouseOrSalesWindowId,
      'StorageLocation': storageLocation,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
