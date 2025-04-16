class ExportManufacturersToExcelQuery {
  final dynamic ids;

  ExportManufacturersToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
