class AddNotificationCommandModel {
  final String title;
  final String body;
  final List<String> userids;
  final bool sendtoAll;

  AddNotificationCommandModel({
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
