
class NotificationDeleteReceivedNotificationsParam {
  final String id;
  final List<String> applicationjson;
  NotificationDeleteReceivedNotificationsParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
