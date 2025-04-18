class ExportWarehousesToExcelQueryParam {
  final List<String> ids;

  ExportWarehousesToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
