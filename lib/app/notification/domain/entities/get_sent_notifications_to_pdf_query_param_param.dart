class GetSentNotificationsToPdfQueryParam {
  final List<String> ids;

  GetSentNotificationsToPdfQueryParam({
    required this.ids,
  });
  Map<String, dynamic> toJson() {
    return {

      'ids': ids,
    };
  }

}
