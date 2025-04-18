
class NotificationDeleteReceivedNotificationsModel {
  final String id;
  final List<String> applicationjson;
  NotificationDeleteReceivedNotificationsModel({required this.id, required this.applicationjson});
  factory NotificationDeleteReceivedNotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationDeleteReceivedNotificationsModel(

      id: json["id"] ,
      applicationjson: json["application/json"],
    );
  }

}
