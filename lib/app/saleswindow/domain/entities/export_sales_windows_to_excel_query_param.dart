class ExportSalesWindowsToExcelQuery {
  final List<String> ids;

  ExportSalesWindowsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
