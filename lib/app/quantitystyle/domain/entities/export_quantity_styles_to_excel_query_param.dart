class ExportQuantityStylesToExcelQuery {
  final List<String> ids;

  ExportQuantityStylesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
