class ExportStoresToExcelQuery {
  final dynamic ids;

  ExportStoresToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
