
class NotificationDeleteSentNotificationsParam {
  final String id;
  final List<String> applicationjson;
  NotificationDeleteSentNotificationsParam({required this.id, required this.applicationjson});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
