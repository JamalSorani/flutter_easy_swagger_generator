
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

      'DateRange.StartDate': dateRangeStartDate,
      'DateRange.EndDate': dateRangeEndDate,
      'EmployeeIds': employeeIds,
      'Search': search,
      'SentBy': sentBy,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
