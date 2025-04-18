class ExportWarehousesToExcelQuery {
  final List<String> ids;

  ExportWarehousesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
