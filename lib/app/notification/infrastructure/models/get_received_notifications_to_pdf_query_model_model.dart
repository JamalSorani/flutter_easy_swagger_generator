class GetReceivedNotificationsToPdfQueryModel {
  final List<String> ids;

  GetReceivedNotificationsToPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
