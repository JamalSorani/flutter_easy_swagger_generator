class ExportCustomersToExcelQueryModel {
  final List<String> customerids;

  ExportCustomersToExcelQueryModel({
    required this.customerids,
  });
  Map<String, dynamic> toJson() {
    return {

      'customerIds': customerids,
    };
  }

}
