class ExportRolesToExcelQueryParam {
  final List<String> ids;

  ExportRolesToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
