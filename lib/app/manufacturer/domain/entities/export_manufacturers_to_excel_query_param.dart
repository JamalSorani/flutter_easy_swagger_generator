class ExportManufacturersToExcelQuery {
  final List<String> ids;

  ExportManufacturersToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
