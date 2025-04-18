class ExportQuantityStylesToExcelQueryModel {
  final List<String> ids;

  ExportQuantityStylesToExcelQueryModel({
    required this.ids,
  });
  factory ExportQuantityStylesToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportQuantityStylesToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
