class ExportManufacturersToExcelQueryParam {
  final List<String> ids;

  ExportManufacturersToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
