class ExportOresToExcelQueryParam {
  final List<String> ids;

  ExportOresToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
