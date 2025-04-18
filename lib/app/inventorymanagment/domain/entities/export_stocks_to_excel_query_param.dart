class ExportStocksToExcelQuery {
  final List<String> ids;

  ExportStocksToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
