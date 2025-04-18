
class NotificationGetReceivedByIdModel {
  final String id;
  NotificationGetReceivedByIdModel({required this.id});
  factory NotificationGetReceivedByIdModel.fromJson(Map<String, dynamic> json) {
    return NotificationGetReceivedByIdModel(

      id: json["Id"] ,
    );
  }

}
