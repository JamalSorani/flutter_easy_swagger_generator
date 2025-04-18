
class EmployeeGetAllModel {
  final String roleId;
  final String status;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  EmployeeGetAllModel({required this.roleId, required this.status, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory EmployeeGetAllModel.fromJson(Map<String, dynamic> json) {
    return EmployeeGetAllModel(

      'RoleId': roleId,
      'Status': status,
      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
