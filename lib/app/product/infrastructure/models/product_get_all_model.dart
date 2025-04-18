
class ProductGetAllModel {
  final String categoryId;
  final String status;
  final String inventoryStatus;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  ProductGetAllModel({required this.categoryId, required this.status, required this.inventoryStatus, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory ProductGetAllModel.fromJson(Map<String, dynamic> json) {
    return ProductGetAllModel(

      'CategoryId': categoryId,
      'Status': status,
      'InventoryStatus': inventoryStatus,
      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
