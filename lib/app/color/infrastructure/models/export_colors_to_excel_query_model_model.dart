class ExportColorsToExcelQueryModel {
  final List<String> ids;

  ExportColorsToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
