class ExportSendNotificationsToExcelQueryParam {
  final List<String> ids;

  ExportSendNotificationsToExcelQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
