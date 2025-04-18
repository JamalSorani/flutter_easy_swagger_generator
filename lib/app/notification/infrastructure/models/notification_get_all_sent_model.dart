
class NotificationGetAllSentModel {
  final String dateRangeStartDate;
  final String dateRangeEndDate;
  final List<String> employeeIds;
  final String search;
  final String sentBy;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  NotificationGetAllSentModel({required this.dateRangeStartDate, required this.dateRangeEndDate, required this.employeeIds, required this.search, required this.sentBy, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory NotificationGetAllSentModel.fromJson(Map<String, dynamic> json) {
    return NotificationGetAllSentModel(

      dateRangeStartDate: json["DateRange.StartDate"] ,
      dateRangeEndDate: json["DateRange.EndDate"] ,
      employeeIds: json["EmployeeIds"] ,
      search: json["Search"] ,
      sentBy: json["SentBy"] ,
      pageSize: json["PageSize"] ,
      pageIndex: json["PageIndex"] ,
      sortOrder: json["SortOrder"] ,
      sortColumn: json["SortColumn"] ,
    );
  }

}
