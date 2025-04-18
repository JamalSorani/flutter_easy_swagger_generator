
class ReportGetAllLowStocksModel {
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  ReportGetAllLowStocksModel({required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory ReportGetAllLowStocksModel.fromJson(Map<String, dynamic> json) {
    return ReportGetAllLowStocksModel(

      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
