
class SalesWindowAppReportGetMostRequestedProductsModel {
  final String search;
  final bool searchOnly;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  SalesWindowAppReportGetMostRequestedProductsModel({required this.search, required this.searchOnly, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory SalesWindowAppReportGetMostRequestedProductsModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppReportGetMostRequestedProductsModel(

      'Search': search,
      'SearchOnly': searchOnly,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
