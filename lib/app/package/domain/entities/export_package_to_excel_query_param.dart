class ExportPackageToExcelQuery {
  final List<String> ids;

  ExportPackageToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
