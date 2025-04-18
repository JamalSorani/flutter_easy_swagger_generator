class ExportSourcesToExcelQuery {
  final List<String> ids;

  ExportSourcesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
