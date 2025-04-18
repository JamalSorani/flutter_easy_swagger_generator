class ExportProductsToExcelQueryParam {
  final List<String> ids;

  ExportProductsToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
