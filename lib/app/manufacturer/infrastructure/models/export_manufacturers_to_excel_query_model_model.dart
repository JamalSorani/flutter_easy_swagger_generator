class ExportManufacturersToExcelQueryModel {
  final List<String> ids;

  ExportManufacturersToExcelQueryModel({
    required this.ids,
  });
  factory ExportManufacturersToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportManufacturersToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
