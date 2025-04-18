class GetReceivedNotificationsToPdfQueryModel {
  final List<String> ids;

  GetReceivedNotificationsToPdfQueryModel({
    required this.ids,
  });
  factory GetReceivedNotificationsToPdfQueryModel.fromJson(Map<String,dynamic>json){
  return GetReceivedNotificationsToPdfQueryModel(

      ids : json["ids"],
    );
  }

}
