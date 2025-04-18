
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

      search: json["Search"] ,
      warehouseOrSalesWindowId: json["WarehouseOrSalesWindowId"] ,
      storageLocation: json["StorageLocation"] ,
      pageSize: json["PageSize"] ,
      pageIndex: json["PageIndex"] ,
      sortOrder: json["SortOrder"] ,
      sortColumn: json["SortColumn"] ,
    );
  }

}
