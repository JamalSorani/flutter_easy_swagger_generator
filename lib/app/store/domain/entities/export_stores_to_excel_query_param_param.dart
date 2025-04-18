class ExportStoresToExcelQueryParam {
  final List<String> ids;

  ExportStoresToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
