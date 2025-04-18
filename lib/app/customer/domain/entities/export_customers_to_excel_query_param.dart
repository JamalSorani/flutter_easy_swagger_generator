class ExportCustomersToExcelQuery {
  final List<String> customerids;

  ExportCustomersToExcelQuery({
    required this.customerids,
  });
  Map<String, dynamic> toJson() {
    return {

      'customerIds': customerids,
    };
  }

}
