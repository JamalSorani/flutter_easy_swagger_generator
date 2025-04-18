class ExportOrdersToExcelQueryModel {
  final List<String> orderids;

  ExportOrdersToExcelQueryModel({
    required this.orderids,
  });
  Map<String, dynamic> toJson() {
    return {

      'orderIds': orderids,
    };
  }

}
