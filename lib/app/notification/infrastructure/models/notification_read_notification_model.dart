
class NotificationReadNotificationModel {
  final String id;
  final List<String> applicationjson;
  NotificationReadNotificationModel({required this.id, required this.applicationjson});
  factory NotificationReadNotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationReadNotificationModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
