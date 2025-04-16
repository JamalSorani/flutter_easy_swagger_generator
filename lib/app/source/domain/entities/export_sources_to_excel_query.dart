class ExportSourcesToExcelQuery {
  final dynamic ids;

  ExportSourcesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
