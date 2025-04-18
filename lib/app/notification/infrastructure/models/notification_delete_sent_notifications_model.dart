
class NotificationDeleteSentNotificationsModel {
  final String id;
  final List<String> applicationjson;
  NotificationDeleteSentNotificationsModel({required this.id, required this.applicationjson});
  factory NotificationDeleteSentNotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationDeleteSentNotificationsModel(

      'id': id,
      'application/json': applicationjson,
    };
  }

}
