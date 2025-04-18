class AddNotificationCommandParam {
  final String title;
  final String body;
  final List<String> userids;
  final bool sendtoAll;

  AddNotificationCommandParam({
    required this.title,
    required this.body,
    required this.userids,
    required this.sendtoAll,
  });
  Map<String, dynamic> toJson() {
    return {

      'title': title,
      'body': body,
      'userIds': userids,
      'sendToAll': sendtoAll,
    };
  }

}
