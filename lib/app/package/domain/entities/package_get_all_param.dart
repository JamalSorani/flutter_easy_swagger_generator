
class PackageGetAllParam {
  final String status;
  final String search;
  final bool isAll;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  PackageGetAllParam({required this.status, required this.search, required this.isAll, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  Map<String, dynamic> toJson() {
    return {

      'Status': status,
      'Search': search,
      'IsAll': isAll,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
