class ExportPackageToExcelQueryModel {
  final List<String> ids;

  ExportPackageToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
