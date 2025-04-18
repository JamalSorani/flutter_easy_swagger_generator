class ExportSendNotificationsToExcelQueryModel {
  final List<String> ids;

  ExportSendNotificationsToExcelQueryModel({
    required this.ids,
  });
  factory ExportSendNotificationsToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportSendNotificationsToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
