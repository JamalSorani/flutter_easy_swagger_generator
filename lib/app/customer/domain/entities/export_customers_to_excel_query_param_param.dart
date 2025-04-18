class ExportCustomersToExcelQueryParam {
  final List<String> customerids;

  ExportCustomersToExcelQueryParam({
    required this.customerids,
  });
  Map<String, dynamic> toJson() {
    return {

      'customerIds': customerids,
    };
  }

}
