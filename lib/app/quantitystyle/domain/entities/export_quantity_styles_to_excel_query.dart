class ExportQuantityStylesToExcelQuery {
  final dynamic ids;

  ExportQuantityStylesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
