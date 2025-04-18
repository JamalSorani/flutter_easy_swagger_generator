class ExportOrdersToExcelQueryParam {
  final List<String> orderids;

  ExportOrdersToExcelQueryParam({
    required this.orderids,
  });
  Map<String, dynamic> toJson() {
    return {

      'orderIds': orderids,
    };
  }

}
