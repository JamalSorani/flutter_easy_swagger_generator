
class NotificationGetReceivedByIdParam {
  final String id;
  NotificationGetReceivedByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
