class ExportMeasurementsToExcelQuery {
  final dynamic ids;

  ExportMeasurementsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
