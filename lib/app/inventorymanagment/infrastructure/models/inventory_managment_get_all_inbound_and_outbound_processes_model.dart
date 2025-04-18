
class InventoryManagmentGetAllInboundAndOutboundProcessesModel {
  final String warehouseIdOrSalesWindowId;
  final String dateRangeStartDate;
  final String dateRangeEndDate;
  final String inventoryManagementType;
  final int number;
  final int pageSize;
  final int pageIndex;
  final String sortOrder;
  final String sortColumn;
  InventoryManagmentGetAllInboundAndOutboundProcessesModel({required this.warehouseIdOrSalesWindowId, required this.dateRangeStartDate, required this.dateRangeEndDate, required this.inventoryManagementType, required this.number, required this.pageSize, required this.pageIndex, required this.sortOrder, required this.sortColumn});
  factory InventoryManagmentGetAllInboundAndOutboundProcessesModel.fromJson(Map<String, dynamic> json) {
    return InventoryManagmentGetAllInboundAndOutboundProcessesModel(

      warehouseIdOrSalesWindowId: json["WarehouseIdOrSalesWindowId"] ,
      dateRangeStartDate: json["DateRange.StartDate"] ,
      dateRangeEndDate: json["DateRange.EndDate"] ,
      inventoryManagementType: json["InventoryManagementType"] ,
      number: json["Number"] ,
      pageSize: json["PageSize"] ,
      pageIndex: json["PageIndex"] ,
      sortOrder: json["SortOrder"] ,
      sortColumn: json["SortColumn"] ,
    );
  }

}
