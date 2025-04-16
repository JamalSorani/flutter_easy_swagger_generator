class GetReceivedNotificationsToPdfQuery {
  final dynamic ids;

  GetReceivedNotificationsToPdfQuery({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
