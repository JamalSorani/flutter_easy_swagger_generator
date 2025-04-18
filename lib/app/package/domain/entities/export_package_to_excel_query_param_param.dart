class ExportPackageToExcelQueryParam {
  final List<String> ids;

  ExportPackageToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
