class GetSentNotificationsToPdfQuery {
  final List<String> ids;

  GetSentNotificationsToPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
