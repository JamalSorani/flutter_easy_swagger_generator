class ExportSalesWindowsToExcelQueryParam {
  final List<String> ids;

  ExportSalesWindowsToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
