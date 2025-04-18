class ExportReceivedNotificationToExcelQueryParam {
  final List<String> ids;

  ExportReceivedNotificationToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
