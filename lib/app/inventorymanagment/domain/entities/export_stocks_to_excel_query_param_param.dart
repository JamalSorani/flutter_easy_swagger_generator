class ExportStocksToExcelQueryParam {
  final List<String> ids;

  ExportStocksToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
