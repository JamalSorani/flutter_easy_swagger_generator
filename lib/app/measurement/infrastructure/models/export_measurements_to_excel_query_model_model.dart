class ExportMeasurementsToExcelQueryModel {
  final List<String> ids;

  ExportMeasurementsToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
