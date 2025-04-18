class GetReceivedNotificationsToPdfQuery {
  final List<String> ids;

  GetReceivedNotificationsToPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
