
class SalesWindowGetAllModel {
  final String employeeId;
  final String status;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  SalesWindowGetAllModel({required this.employeeId, required this.status, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory SalesWindowGetAllModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowGetAllModel(

      'EmployeeId': employeeId,
      'Status': status,
      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
