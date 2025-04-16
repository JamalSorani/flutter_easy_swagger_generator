class ExportSendNotificationsToExcelQuery {
  final dynamic ids;

  ExportSendNotificationsToExcelQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
