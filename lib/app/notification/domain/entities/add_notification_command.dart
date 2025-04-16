class AddNotificationCommand {
  final String title;
  final String body;
  final dynamic userids;
  final bool sendtoAll;

  AddNotificationCommand({
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
