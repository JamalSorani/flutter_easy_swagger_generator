class ExportWarehousesToExcelQuery {
  final dynamic ids;

  ExportWarehousesToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
