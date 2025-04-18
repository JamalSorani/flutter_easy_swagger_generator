class ExportRolesToExcelQueryModel {
  final List<String> ids;

  ExportRolesToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
