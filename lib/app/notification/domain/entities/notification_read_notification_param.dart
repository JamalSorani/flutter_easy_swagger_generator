
class NotificationReadNotificationParam {
  final String id;
  NotificationReadNotificationParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'id': id,
    };
  }

}
