class ExportSourcesToExcelQueryParam {
  final List<String> ids;

  ExportSourcesToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
