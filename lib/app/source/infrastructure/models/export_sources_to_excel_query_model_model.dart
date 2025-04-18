class ExportSourcesToExcelQueryModel {
  final List<String> ids;

  ExportSourcesToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
