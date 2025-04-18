
class SalesWindowAppReportGetMostRequestedPackagesModel {
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  SalesWindowAppReportGetMostRequestedPackagesModel({required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory SalesWindowAppReportGetMostRequestedPackagesModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppReportGetMostRequestedPackagesModel(

      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
