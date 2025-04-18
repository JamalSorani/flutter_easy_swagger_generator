class ExportStoresToExcelQuery {
  final List<String> ids;

  ExportStoresToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
