class ExportRolesToExcelQueryModel {
  final List<String> ids;

  ExportRolesToExcelQueryModel({
    required this.ids,
  });
  factory ExportRolesToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportRolesToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
