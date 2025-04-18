class GetSentNotificationsToPdfQueryModel {
  final List<String> ids;

  GetSentNotificationsToPdfQueryModel({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
