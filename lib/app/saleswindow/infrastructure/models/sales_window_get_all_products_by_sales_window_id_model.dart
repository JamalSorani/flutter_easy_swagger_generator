
class SalesWindowGetAllProductsBySalesWindowIdModel {
  final String salesWindowId;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  SalesWindowGetAllProductsBySalesWindowIdModel({required this.salesWindowId, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory SalesWindowGetAllProductsBySalesWindowIdModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowGetAllProductsBySalesWindowIdModel(

      'SalesWindowId': salesWindowId,
      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
