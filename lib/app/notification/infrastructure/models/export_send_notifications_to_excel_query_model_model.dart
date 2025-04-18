class ExportSendNotificationsToExcelQueryModel {
  final List<String> ids;

  ExportSendNotificationsToExcelQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
