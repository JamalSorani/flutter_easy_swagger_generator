
class RoleGetAllRolesModel {
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  RoleGetAllRolesModel({required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory RoleGetAllRolesModel.fromJson(Map<String, dynamic> json) {
    return RoleGetAllRolesModel(

      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
