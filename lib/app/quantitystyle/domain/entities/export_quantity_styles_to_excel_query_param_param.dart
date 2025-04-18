class ExportQuantityStylesToExcelQueryParam {
  final List<String> ids;

  ExportQuantityStylesToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
