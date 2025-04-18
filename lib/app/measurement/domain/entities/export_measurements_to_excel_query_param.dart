class ExportMeasurementsToExcelQuery {
  final List<String> ids;

  ExportMeasurementsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
