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
  factory AddNotificationCommandModel.fromJson(Map<String,dynamic>json){
  return AddNotificationCommandModel(

      title : json["title"],
      body : json["body"],
      userids : json["userIds"],
      sendtoAll : json["sendToAll"],
    );
  }

}
