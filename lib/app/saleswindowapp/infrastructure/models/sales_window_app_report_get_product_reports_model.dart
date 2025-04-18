
class SalesWindowAppReportGetProductReportsModel {
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  SalesWindowAppReportGetProductReportsModel({required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory SalesWindowAppReportGetProductReportsModel.fromJson(Map<String, dynamic> json) {
    return SalesWindowAppReportGetProductReportsModel(

      pageSize: json["PageSize"] ,
      pageIndex: json["PageIndex"] ,
      sortOrder: json["SortOrder"] ,
      sortColumn: json["SortColumn"] ,
    );
  }

}
