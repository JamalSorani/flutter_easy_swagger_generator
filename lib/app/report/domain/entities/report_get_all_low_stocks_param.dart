
class ReportGetAllLowStocksParam {
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  ReportGetAllLowStocksParam({required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  Map<String, dynamic> toJson() {
    return {

      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
