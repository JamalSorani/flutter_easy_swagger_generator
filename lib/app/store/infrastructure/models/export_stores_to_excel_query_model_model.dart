class ExportStoresToExcelQueryModel {
  final List<String> ids;

  ExportStoresToExcelQueryModel({
    required this.ids,
  });
  factory ExportStoresToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportStoresToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
