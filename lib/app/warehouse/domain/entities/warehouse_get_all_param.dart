
class WarehouseGetAllParam {
  final dynamic employeeids;
  final String status;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  WarehouseGetAllParam({required this.employeeids, required this.status, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  Map<String, dynamic> toJson() {
    return {

      'employeeIds': employeeids,
      'status': status,
      'search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
