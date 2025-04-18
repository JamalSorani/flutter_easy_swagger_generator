class ExportMeasurementsToExcelQueryParam {
  final List<String> ids;

  ExportMeasurementsToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
