
class WarehouseGetAllProductsByWarehouseIdParam {
  final String warehouseId;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  WarehouseGetAllProductsByWarehouseIdParam({required this.warehouseId, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  Map<String, dynamic> toJson() {
    return {

      'WarehouseId': warehouseId,
      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
