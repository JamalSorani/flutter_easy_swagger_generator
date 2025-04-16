class ExportProductsToExcelQuery {
  final String warehouseid;
  final dynamic productids;

  ExportProductsToExcelQuery({
    required this.warehouseid,
    required this.productids,
  });
  Map<String, dynamic> toJson() {
    return {

      'warehouseId': warehouseid,
      'productIds': productids,
    };
  }

}
