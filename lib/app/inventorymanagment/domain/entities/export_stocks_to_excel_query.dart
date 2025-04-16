class ExportStocksToExcelQuery {
  final dynamic ids;

  ExportStocksToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
