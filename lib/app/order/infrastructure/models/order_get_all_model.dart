
class OrderGetAllModel {
  final String employeeId;
  final String dateRangeStartDate;
  final String dateRangeEndDate;
  final String status;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  OrderGetAllModel({required this.employeeId, required this.dateRangeStartDate, required this.dateRangeEndDate, required this.status, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory OrderGetAllModel.fromJson(Map<String, dynamic> json) {
    return OrderGetAllModel(

      employeeId: json["EmployeeId"] ,
      dateRangeStartDate: json["DateRange.StartDate"] ,
      dateRangeEndDate: json["DateRange.EndDate"] ,
      status: json["Status"] ,
      search: json["Search"] ,
      pageSize: json["PageSize"] ,
      pageIndex: json["PageIndex"] ,
      sortOrder: json["SortOrder"] ,
      sortColumn: json["SortColumn"] ,
    );
  }

}
