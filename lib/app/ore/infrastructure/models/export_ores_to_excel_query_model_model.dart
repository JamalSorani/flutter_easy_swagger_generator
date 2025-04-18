class ExportOresToExcelQueryModel {
  final List<String> ids;

  ExportOresToExcelQueryModel({
    required this.ids,
  });
  factory ExportOresToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportOresToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
