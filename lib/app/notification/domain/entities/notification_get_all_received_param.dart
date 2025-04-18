
class NotificationGetAllReceivedParam {
  final String mode;
  final String dateRangeStartDate;
  final String dateRangeEndDate;
  final String status;
  final String search;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  NotificationGetAllReceivedParam({required this.mode, required this.dateRangeStartDate, required this.dateRangeEndDate, required this.status, required this.search, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  Map<String, dynamic> toJson() {
    return {

      'Mode': mode,
      'DateRange.StartDate': dateRangeStartDate,
      'DateRange.EndDate': dateRangeEndDate,
      'Status': status,
      'Search': search,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
