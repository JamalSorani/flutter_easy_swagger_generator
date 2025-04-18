class ExportReceivedNotificationToExcelQuery {
  final List<String> ids;

  ExportReceivedNotificationToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
