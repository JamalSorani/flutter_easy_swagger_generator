class ExportStocksToExcelQueryModel {
  final List<String> ids;

  ExportStocksToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
