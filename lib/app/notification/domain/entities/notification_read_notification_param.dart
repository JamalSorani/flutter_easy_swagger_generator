
class NotificationReadNotificationParam {
  final String id;
  final List<String> applicationjson;
  NotificationReadNotificationParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'application/json': applicationjson,
    };
  }

}
