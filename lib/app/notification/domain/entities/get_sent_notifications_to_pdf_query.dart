class GetSentNotificationsToPdfQuery {
  final dynamic ids;

  GetSentNotificationsToPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
