class ExportReceivedNotificationToExcelQuery {
  final dynamic ids;

  ExportReceivedNotificationToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
