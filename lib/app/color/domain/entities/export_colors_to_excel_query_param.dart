class ExportColorsToExcelQuery {
  final List<String> ids;

  ExportColorsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
