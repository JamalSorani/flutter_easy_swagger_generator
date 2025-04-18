class ExportColorsToExcelQueryModel {
  final List<String> ids;

  ExportColorsToExcelQueryModel({
    required this.ids,
  });
  factory ExportColorsToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportColorsToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
