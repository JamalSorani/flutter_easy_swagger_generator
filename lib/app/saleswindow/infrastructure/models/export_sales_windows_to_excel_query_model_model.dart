class ExportSalesWindowsToExcelQueryModel {
  final List<String> ids;

  ExportSalesWindowsToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
