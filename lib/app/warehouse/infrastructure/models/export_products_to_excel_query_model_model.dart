class ExportProductsToExcelQueryModel {
  final String warehouseid;
  final List<String> productids;

  ExportProductsToExcelQueryModel({
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
