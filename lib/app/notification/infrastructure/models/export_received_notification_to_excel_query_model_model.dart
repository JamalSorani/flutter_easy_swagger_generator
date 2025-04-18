class ExportReceivedNotificationToExcelQueryModel {
  final List<String> ids;

  ExportReceivedNotificationToExcelQueryModel({
    required this.ids,
  });
  factory ExportReceivedNotificationToExcelQueryModel.fromJson(Map<String,dynamic>json){
  return ExportReceivedNotificationToExcelQueryModel(

      ids : json["ids"],
    );
  }

}
