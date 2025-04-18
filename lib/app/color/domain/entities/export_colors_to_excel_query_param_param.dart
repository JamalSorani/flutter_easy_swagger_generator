class ExportColorsToExcelQueryParam {
  final List<String> ids;

  ExportColorsToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
