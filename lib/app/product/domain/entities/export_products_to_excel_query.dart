class ExportProductsToExcelQuery {
  final dynamic ids;

  ExportProductsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
