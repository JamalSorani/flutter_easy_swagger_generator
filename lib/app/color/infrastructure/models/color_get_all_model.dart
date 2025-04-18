
class ColorGetAllModel {
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  ColorGetAllModel({required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory ColorGetAllModel.fromJson(Map<String, dynamic> json) {
    return ColorGetAllModel(

      search: json["Search"] ,
      pageSize: json["PageSize"] ,
      pageIndex: json["PageIndex"] ,
      sortOrder: json["SortOrder"] ,
      sortColumn: json["SortColumn"] ,
    );
  }

}
