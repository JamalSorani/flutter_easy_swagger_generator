
class SalesWindowAppReportGetMostRequestedProductsParam {
  final String search;
  final bool searchOnly;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  SalesWindowAppReportGetMostRequestedProductsParam({required this.search, required this.searchOnly, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  Map<String, dynamic> toJson() {
    return {

      'Search': search,
      'SearchOnly': searchOnly,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
