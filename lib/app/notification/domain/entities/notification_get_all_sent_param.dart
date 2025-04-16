
class NotificationGetAllSentParam {
  final String dateRangeStartDate;
  final String dateRangeEndDate;
  final dynamic employeeIds;
  final String search;
  final String sentBy;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  NotificationGetAllSentParam({required this.dateRangeStartDate, required this.dateRangeEndDate, required this.employeeIds, required this.search, required this.sentBy, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  Map<String, dynamic> toJson() {
    return {

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
