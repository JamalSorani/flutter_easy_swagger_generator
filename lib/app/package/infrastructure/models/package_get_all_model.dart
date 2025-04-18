
class PackageGetAllModel {
  final String status;
  final String search;
  final bool isAll;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  PackageGetAllModel({required this.status, required this.search, required this.isAll, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory PackageGetAllModel.fromJson(Map<String, dynamic> json) {
    return PackageGetAllModel(

      status: json["Status"] ,
      search: json["Search"] ,
      isAll: json["IsAll"] ,
      pageSize: json["PageSize"] ,
      pageIndex: json["PageIndex"] ,
      sortOrder: json["SortOrder"] ,
      sortColumn: json["SortColumn"] ,
    );
  }

}
