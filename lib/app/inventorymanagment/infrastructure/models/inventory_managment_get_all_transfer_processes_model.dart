
class InventoryManagmentGetAllTransferProcessesModel {
  final String warehouseIdOrSalesWindowId;
  final String dateRangeStartDate;
  final String dateRangeEndDate;
  final int number;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  InventoryManagmentGetAllTransferProcessesModel({required this.warehouseIdOrSalesWindowId, required this.dateRangeStartDate, required this.dateRangeEndDate, required this.number, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory InventoryManagmentGetAllTransferProcessesModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentGetAllTransferProcessesModel(

      'WarehouseIdOrSalesWindowId': warehouseIdOrSalesWindowId,
      'DateRange.StartDate': dateRangeStartDate,
      'DateRange.EndDate': dateRangeEndDate,
      'Number': number,
      'PageSize': pageSize,
      'PageIndex': pageIndex,
      'SortOrder': sortOrder,
      'SortColumn': sortColumn,
    };
  }

}
