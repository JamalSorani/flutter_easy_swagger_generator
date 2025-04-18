class ExportProductsToExcelQueryParam {
  final String warehouseid;
  final List<String> productids;

  ExportProductsToExcelQueryParam({
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
