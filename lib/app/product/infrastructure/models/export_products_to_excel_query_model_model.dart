class ExportProductsToExcelQueryModel {
  final List<String> ids;

  ExportProductsToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
