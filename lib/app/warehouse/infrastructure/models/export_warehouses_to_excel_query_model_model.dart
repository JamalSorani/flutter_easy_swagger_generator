class ExportWarehousesToExcelQueryModel {
  final List<String> ids;

  ExportWarehousesToExcelQueryModel({
    required this.ids,
  });
  factory ExportWarehousesToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportWarehousesToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
