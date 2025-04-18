class ExportRolesToExcelQuery {
  final List<String> ids;

  ExportRolesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
