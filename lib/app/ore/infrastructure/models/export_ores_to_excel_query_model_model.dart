class ExportOresToExcelQueryModel {
  final List<String> ids;

  ExportOresToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
