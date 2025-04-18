
class WarehouseGetAllProductsByWarehouseIdModel {
  final String warehouseId;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  WarehouseGetAllProductsByWarehouseIdModel({required this.warehouseId, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory WarehouseGetAllProductsByWarehouseIdModel.fromJson(Map<String, dynamic> json) {
    return WarehouseGetAllProductsByWarehouseIdModel(

      warehouseId: json["WarehouseId"] ,
      search: json["Search"] ,
      pageSize: json["PageSize"] ,
      pageIndex: json["PageIndex"] ,
      sortOrder: json["SortOrder"] ,
      sortColumn: json["SortColumn"] ,
    );
  }

}
