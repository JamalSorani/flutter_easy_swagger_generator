
class NotificationGetSentByIdParam {
  final String id;
  NotificationGetSentByIdParam({required this.id});
  Map<String, dynamic> toJson() {
    return {

      'Id': id,
    };
  }

}
