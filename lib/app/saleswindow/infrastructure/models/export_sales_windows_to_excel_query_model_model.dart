class ExportSalesWindowsToExcelQueryModel {
  final List<String> ids;

  ExportSalesWindowsToExcelQueryModel({
    required this.ids,
  });
  factory ExportSalesWindowsToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportSalesWindowsToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
