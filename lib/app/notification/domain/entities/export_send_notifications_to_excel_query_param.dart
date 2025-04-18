class ExportSendNotificationsToExcelQuery {
  final List<String> ids;

  ExportSendNotificationsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
