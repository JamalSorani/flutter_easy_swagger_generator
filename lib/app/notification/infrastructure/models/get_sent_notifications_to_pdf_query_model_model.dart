class GetSentNotificationsToPdfQueryModel {
  final List<String> ids;

  GetSentNotificationsToPdfQueryModel({
    required this.ids,
  });
  factory GetSentNotificationsToPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetSentNotificationsToPdfQueryModel(

      ids : json["ids"],
    );
  }

}
