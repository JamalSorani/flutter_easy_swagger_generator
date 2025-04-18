class GetReceivedNotificationsToPdfQueryParam {
  final List<String> ids;

  GetReceivedNotificationsToPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
