class ExportMeasurementsToExcelQueryModel {
  final List<String> ids;

  ExportMeasurementsToExcelQueryModel({
    required this.ids,
  });
  factory ExportMeasurementsToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportMeasurementsToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
