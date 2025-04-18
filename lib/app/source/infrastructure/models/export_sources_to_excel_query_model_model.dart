class ExportSourcesToExcelQueryModel {
  final List<String> ids;

  ExportSourcesToExcelQueryModel({
    required this.ids,
  });
  factory ExportSourcesToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportSourcesToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
