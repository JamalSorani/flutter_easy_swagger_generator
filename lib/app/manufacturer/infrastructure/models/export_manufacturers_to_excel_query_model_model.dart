class ExportManufacturersToExcelQueryModel {
  final List<String> ids;

  ExportManufacturersToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
