class ExportStoresToExcelQueryModel {
  final List<String> ids;

  ExportStoresToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
