
class RoleGetAllRolesModel {
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  RoleGetAllRolesModel({required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory RoleGetAllRolesModel.fromJson(Map<String, dynamic> json) {
    return RoleGetAllRolesModel(

      search: json["Search"] ,
      pageSize: json["PageSize"] ,
      pageIndex: json["PageIndex"] ,
      sortOrder: json["SortOrder"] ,
      sortColumn: json["SortColumn"] ,
    );
  }

}
