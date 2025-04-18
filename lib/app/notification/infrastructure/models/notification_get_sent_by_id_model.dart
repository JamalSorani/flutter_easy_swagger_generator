
class NotificationGetSentByIdModel {
  final String id;
  NotificationGetSentByIdModel({required this.id});
  factory NotificationGetSentByIdModel.fromJson(Map<String, dynamic> json) {
    return NotificationGetSentByIdModel(

      id: json["Id"] ,
    );
  }

}
