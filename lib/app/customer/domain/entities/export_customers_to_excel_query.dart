class ExportCustomersToExcelQuery {
  final dynamic customerids;

  ExportCustomersToExcelQuery({
    required this.customerids,
  });
  Map<String, dynamic> toJson() {
    return {

      'customerIds': customerids,
    };
  }

}
