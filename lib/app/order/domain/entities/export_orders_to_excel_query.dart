class ExportOrdersToExcelQuery {
  final dynamic orderids;

  ExportOrdersToExcelQuery({
    required this.orderids,
  });
  Map<String, dynamic> toJson() {
    return {

      'orderIds': orderids,
    };
  }

}
