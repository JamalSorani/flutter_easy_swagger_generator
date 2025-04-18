class ExportQuantityStylesToExcelQueryModel {
  final List<String> ids;

  ExportQuantityStylesToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
