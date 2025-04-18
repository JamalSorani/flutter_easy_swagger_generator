class ExportPackageToExcelQueryModel {
  final List<String> ids;

  ExportPackageToExcelQueryModel({
    required this.ids,
  });
  factory ExportPackageToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportPackageToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
