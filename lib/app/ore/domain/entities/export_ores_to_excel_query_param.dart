class ExportOresToExcelQuery {
  final List<String> ids;

  ExportOresToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
