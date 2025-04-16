class ExportSalesWindowsToExcelQuery {
  final dynamic ids;

  ExportSalesWindowsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
