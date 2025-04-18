class ExportWarehousesToExcelQueryModel {
  final List<String> ids;

  ExportWarehousesToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
