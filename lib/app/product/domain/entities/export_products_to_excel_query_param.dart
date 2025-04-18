class ExportProductsToExcelQuery {
  final List<String> ids;

  ExportProductsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
