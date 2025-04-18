
class WarehouseGetAllModel {
  final List<String> employeeids;
  final String status;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  WarehouseGetAllModel({required this.employeeids, required this.status, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory WarehouseGetAllModel.fromJson(Map<String, dynamic> json) {
    return WarehouseGetAllModel(

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
