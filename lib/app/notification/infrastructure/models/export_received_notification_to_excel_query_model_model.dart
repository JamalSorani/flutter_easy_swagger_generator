class ExportReceivedNotificationToExcelQueryModel {
  final List<String> ids;

  ExportReceivedNotificationToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
