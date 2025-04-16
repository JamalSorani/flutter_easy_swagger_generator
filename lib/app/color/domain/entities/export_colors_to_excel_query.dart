class ExportColorsToExcelQuery {
  final dynamic ids;

  ExportColorsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
