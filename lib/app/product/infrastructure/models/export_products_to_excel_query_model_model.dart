class ExportProductsToExcelQueryModel {
  final List<String> ids;

  ExportProductsToExcelQueryModel({
    required this.ids,
  });
  factory ExportProductsToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportProductsToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
