class ExportPackageToExcelQuery {
  final dynamic ids;

  ExportPackageToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
