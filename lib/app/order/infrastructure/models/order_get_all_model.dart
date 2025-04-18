
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

      'EmployeeId': employeeId,
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
