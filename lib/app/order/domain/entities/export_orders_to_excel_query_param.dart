class ExportOrdersToExcelQuery {
  final List<String> orderids;

  ExportOrdersToExcelQuery({
    required this.orderids,
  });
  Map<String, dynamic> toJson() {
    return {

      'orderIds': orderids,
    };
  }

}
